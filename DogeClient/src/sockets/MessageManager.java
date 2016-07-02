package sockets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.ejb.AccessTimeout;
import javax.ejb.EJB;
import javax.ejb.Singleton;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import model.Question;
import rete.ReteRemote;

@ServerEndpoint("/websocket")
@Singleton
public class MessageManager {

	@EJB
	ReteRemote reteBean;
	
	//private List<Session> sessions;
	private Map<String, Session> sessions;
	private Map<String, List<Question>> questions;
	private Map<String, Boolean> states;
	
	public MessageManager()
	{
		//sessions = new ArrayList<Session>();
		sessions = new HashMap<String, Session>();
		questions = new HashMap<String, List<Question>>();
		states = new HashMap<String, Boolean>();
	}
	
	@PostConstruct
	public void initRete()
	{
	}
	
	@OnOpen
	@AccessTimeout(20000)
	public void onOpen(Session session) 
	{
		System.out.println("Openning connection");
		if(sessions.get(session.getId()) == null)
		{
			sessions.put(session.getId(), session);
			questions.put(session.getId(), new ArrayList<Question>());
			states.put(session.getId(), false); //false
		}
	}
	
	@OnMessage
	@AccessTimeout(20000)
	public void handleMessage(Session session, String message, boolean last) throws IOException
	{
		System.out.println("Message: " + message);
		
		if(message.startsWith("init"))
		{
			//remove existing facts and questions for user, and start from beginning
			removeQuestions(session.getId());
			reteBean.removeFactsForUser(session.getId());
			String[] parts = message.split(":");
			reteBean.assertInitialFact(session.getId(), parts[1]);
		}
		else if(message.equals("ready"))
		{
			states.put(session.getId(), true);
			sendQuestion(session);
		}
		else if(message.equals("remove"))
		{
			reteBean.removeFactsForUser(session.getId());
		}
		else if(message.startsWith("true"))
		{
			//true:symptom:name
			String[] parts = message.split(":");
			
			System.out.println(questions);
			System.out.println(message);
			reteBean.assertFactFor(session.getId(), parts[1], parts[2], true);
			states.put(session.getId(), true);
			sendQuestion(session);
		}
		else if(message.startsWith("false"))
		{
			//false:symptom:name
			String[] parts = message.split(":");
			
			if(!parts[1].equals("localization"))
			{
				System.out.println(questions);
				System.out.println(message);
				reteBean.assertFactFor(session.getId(), parts[1], parts[2], false);
				states.put(session.getId(), true);
				sendQuestion(session);
			}
			else	//ukoliko je false za lokalizaciju, samo se prosledi sledece pitanje
			{
				states.put(session.getId(), true);
				sendQuestion(session);
			}
		}
		else if(message.equals("facts"))
		{
			reteBean.listFacts();
		}
		else if(message.startsWith("question"))	//treba da dodamo question za usera
		{
			//question:user:type:name:text
			//type = symptom/localization...
			//name = fear-induced/parental...
			//text = question text
			String[] parts = message.split(":");
			if(parts[0].equals("question") && !parts[1].equals("nil"))
			{
				//dobijemo pitanje, dodamo u listu pitanja za konkretnog usera
				questions.get(parts[1]).add(0, (new Question(parts[2], parts[3], parts[4])));
				sendQuestion(sessions.get(parts[1]));
				//sessions.get(parts[1]).getBasicRemote().sendText(parts[2] + ":" + parts[3]);
			}
		}
		else if(message.startsWith("diagnosis"))
		{
			String[] parts = message.split(":");
			sessions.get(parts[1]).getBasicRemote().sendText("diagnosis:" + parts[2]);
		}
	}
	
	@OnClose
	public void close(Session session)
	{
		reteBean.removeFactsForUser(session.getId());
		removeUser(session.getId());
	}
	
	@OnError
	public void error(Session session, Throwable t)
	{
		reteBean.removeFactsForUser(session.getId());
		removeUser(session.getId());
		System.out.println("Socket closed because of error : " + t.getMessage());
	}
	
	private void sendQuestion(Session session)
	{
		try {
			
			//uzmemo poslednje dodato pitanje, posaljemo klijentu i izbacimo iz liste
			if(questions.get(session.getId()).size() > 0 && states.get(session.getId()))
			{
				//zabrani slanje ostalih pitanja
				states.put(session.getId(), false);
				
				Question question = questions.get(session.getId()).get(0);
				questions.get(session.getId()).remove(0);
				
				session.getBasicRemote().sendText(question.getType() + ":" + question.getName() + ":" + question.getText());
				//postavi da korisnik odgovara na pitanje
			}
			else
			{
				System.out.println("Not sending question");
				System.out.println(session.getId());
				System.out.println(questions.get(session.getId()).size());
				System.out.println(states.get(session.getId()));
				System.out.println("No questions to send");
				/*if(!states.get(session.getId()))
				{
					session.getBasicRemote().sendText("noquestions");
				}*/
				if(questions.get(session.getId()).isEmpty())
				{
					session.getBasicRemote().sendText("noquestions");				}
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Failed sending message to client");
			System.out.println(e.getMessage());
		}
	}
	
	private void removeUser(String sessionId)
	{
		sessions.remove(sessionId);
		questions.remove(sessionId);
		states.remove(sessionId);
	}
	
	private void removeQuestions(String sessionId)
	{
		questions.get(sessionId).clear();
	}
}
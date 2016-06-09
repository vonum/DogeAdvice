package sockets;

import java.io.IOException;
import java.util.HashMap;
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

import rete.ReteRemote;

@ServerEndpoint("/websocket")
@Singleton
public class MessageManager {

	@EJB
	ReteRemote reteBean;
	
	//private List<Session> sessions;
	private Map<String, Session> sessions;
	
	public MessageManager()
	{
		//sessions = new ArrayList<Session>();
		sessions = new HashMap<String, Session>();
	}
	
	@PostConstruct
	public void initRete()
	{
		reteBean.test();
	}
	
	@OnOpen
	@AccessTimeout(20000)
	public void onOpen(Session session) 
	{
		if(sessions.get(session.getId()) != null)
		{
			sessions.put(session.getId(), session);
		}
	}
	
	@OnMessage
	@AccessTimeout(20000)
	public void handleMessage(Session session, String message, boolean last)
	{
		System.out.println("WE GOT A MESSAGE");
		System.out.println(message);
		try {
			session.getBasicRemote().sendText("Reply from server");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.getMessage();
		}
		//reteBean.test();
	}
	
	@OnClose
	public void close(Session session)
	{
		sessions.remove(session.getId());
	}
	
	@OnError
	public void error(Session session, Throwable t)
	{
		sessions.remove(session.getId());
		t.printStackTrace();
	}
}
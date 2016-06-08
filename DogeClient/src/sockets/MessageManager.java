package sockets;

import java.util.ArrayList;
import java.util.List;

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
	
	private List<Session> sessions;
	
	public MessageManager()
	{
		sessions = new ArrayList<Session>();
	}
	
	@OnOpen
	public void onOpen(Session session) 
	{
		if(!sessions.contains(session))
		{
			sessions.add(session);
		}
	}
	
	@OnMessage
	public void handleMessage(Session session, String message, boolean last)
	{
		System.out.println("WE GOT A MESSAGE");
		System.out.println(message);
		reteBean.test();
	}
	
	@OnClose
	public void close(Session session)
	{
		sessions.remove(session);
	}
	
	@OnError
	public void error(Session session, Throwable t)
	{
		sessions.remove(session);
		t.printStackTrace();
	}
}
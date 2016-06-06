package socket;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Singleton;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@Singleton
@ServerEndpoint("/websocket")
public class MessageManager {

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

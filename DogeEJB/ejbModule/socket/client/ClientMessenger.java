package socket.client;

import java.io.IOException;
import java.net.URI;

import javax.websocket.ClientEndpoint;
import javax.websocket.ContainerProvider;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

@ClientEndpoint
public class ClientMessenger {
	
	private Session session;
	public boolean ready;
	
	public ClientMessenger(String URL)
	{
	    System.out.println(URL);
	    try
	    {
	    	WebSocketContainer container = ContainerProvider.
	        getWebSocketContainer();
	        container.connectToServer(this, new URI(URL));
	        ready = false;
	    }
	    catch(Exception ex)
	    {	
	    	System.out.println("Could not establish connection from client");
	    	System.out.println(ex.getMessage());
	    }
	}
	
	@OnOpen
	public void onOpen(Session session)
	{
		this.session = session;
		ready = true;
	}
	 
	@OnMessage
	public void onMessage(String message, Session session)
	{
	    System.out.println(message);
	}
	 
	public void sendMessage(String message)
	{
		while(!ready)
		{
			//wait
		}
		try
		{
			if(session != null)
			{
				session.getBasicRemote().sendText(message);
			}
			else
			{
				System.out.println("Session is null");
			}
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
	}

}

package socket.client;

import java.io.IOException;
import java.net.URI;

import javax.ejb.AccessTimeout;
import javax.websocket.ClientEndpoint;
import javax.websocket.ContainerProvider;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

@ClientEndpoint
public class ClientMessenger {
	
	private Session session;
	private boolean ready;
	
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
		System.out.println("Connection established");
		this.session = session;
		ready = true;
		System.out.println("SET TO READY");
	}
	 
	@OnMessage
	public void onMessage(String message, Session session)
	{
	    //System.out.println(message);
	}
	 
	public void sendMessage(String message)
	{
		System.out.println("Sending message to ServerEndpoint");
		/*while(!ready)
		{
			System.out.println("pls");
			//wait
		}*/
		try
		{
			if(session != null)
			{
				System.out.println("CLIENT SOCKET SENDING MESSAGE");
				System.out.println(ready);
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

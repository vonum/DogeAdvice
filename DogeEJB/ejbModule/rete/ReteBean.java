package rete;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import jess.JessException;
import jess.Rete;
import socket.client.ClientMessenger;

/**
 * Session Bean implementation class ReteBean
 */
@Stateless
@LocalBean
public class ReteBean implements ReteRemote {

	private Rete engine;
    /**
     * Default constructor. 
     * @throws JessException 
     */
    public ReteBean() throws JessException {
        // TODO Auto-generated constructor stub
    	engine = new Rete();
    	engine.store("bridge", new ClientMessenger("ws://localhost:8080/DogeClient/websocket"));
    	engine.batch("rules/test.clp");
    	engine.run();
    }
	@Override
	public void test() {
		// TODO Auto-generated method stub
		try {
			engine.eval("(printout t \"message from rete\" crlf)");
		} catch (JessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

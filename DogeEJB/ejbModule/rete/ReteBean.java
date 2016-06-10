package rete;

import javax.ejb.LocalBean;
import javax.ejb.Singleton;

import jess.Fact;
import jess.JessException;
import jess.RU;
import jess.Rete;
import jess.Value;
import socket.client.ClientMessenger;
import thread.EngineThread;

/**
 * Session Bean implementation class ReteBean
 */
@Singleton
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
    	engine.batch("templates/templates.clp");
    	//engine.run();
    	new EngineThread(engine).start();
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
	@Override
	public void listFacts() {
		// TODO Auto-generated method stub
		try {
			engine.eval("(facts)");
		} catch (JessException e) {
			// TODO Auto-generated catch block
			System.out.println("Could not list facts, RETE");
			e.getMessage();
		}
	}
	@Override
	public void assertFact(String sessionId) {
		// TODO Auto-generated method stub
		try {
			Fact fact = new Fact("symptom", engine);
			fact.setSlotValue("name", new Value("pls", RU.STRING));
			fact.setSlotValue("value", new Value("TRUE", RU.SYMBOL));
			fact.setSlotValue("user", new Value(sessionId, RU.STRING));
			engine.assertFact(fact);
		} catch (JessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

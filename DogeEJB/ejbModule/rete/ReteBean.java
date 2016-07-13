package rete;

import java.util.Iterator;

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
    	//engine.batch("rules/test.clp");
    	//napraviti da ucita sve clp file-ove i batchuje, proslediti nazive paketa, i ucitati sve clp-ove iz tog paketa
    	engine.batch("templates/templates.clp");
    	
    	engine.batch("rules/general.clp");
    	engine.batch("rules/aggression.clp");
    	engine.batch("rules/coughing.clp");
    	engine.batch("rules/deafness.clp");
    	engine.batch("rules/sight.clp");
    	
    	engine.batch("questions/aggression-questions.clp");
    	engine.batch("questions/coughing-questions.clp");
    	engine.batch("questions/deafness-questions.clp");
    	engine.batch("questions/sight-questions.clp");
    	
    	engine.batch("rules/init.clp");
    	
    	new EngineThread(engine).start();
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
	public void assertInitialFact(String sessionId, String category) {
		// TODO Auto-generated method stub
		try {
			Fact fact = new Fact("symptom", engine);
			fact.setSlotValue("name", new Value(category, RU.SYMBOL));
			fact.setSlotValue("value", new Value("TRUE", RU.SYMBOL));
			fact.setSlotValue("user", new Value(sessionId, RU.STRING));
			engine.assertFact(fact);
		} catch (JessException e) {
			// TODO Auto-generated catch block
			System.out.println("Falied asserting fact");
			System.out.println(e.getMessage());
		}
	}
	@Override
	public void assertFactFor(String sessionId, String type, String name, boolean response) {
		
		try {
		
			//Fact need_symptom = engine.fetch(sessionId).factValue(engine.getGlobalContext());
		
			Fact fact = new Fact(type, engine);
			//fact.setSlotValue("name", need_symptom.getSlotValue("name"));
			fact.setSlotValue("name", new Value(name, RU.SYMBOL));
			if (type.equals("symptom")) fact.setSlotValue("value", new Value(response ? "TRUE" : "FALSE", RU.SYMBOL));
			fact.setSlotValue("user", new Value(sessionId, RU.STRING));
			
			engine.assertFact(fact);
			
		} catch (JessException e) {
			// TODO Auto-generated catch block
			System.out.println("Falied asserting fact");
			System.out.println(e.getMessage());
		}
		
	}
	@Override
	public Object fetchObject(String name) {
		// TODO Auto-generated method stub
		return engine.fetch(name);
	}
	@Override
	public void removeFactsForUser(String sessionId) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		Iterator<Fact> it = engine.listFacts();
        while (it.hasNext()) 
        {
        	Fact f = (Fact) it.next();
        	//System.out.println("Za fakt sa rednim brojem " + fa.getFactId() + " tipa " + fa.getName());
        	
    		try {
				if(f.getSlotValue("user").stringValue(null).equals(sessionId))
				{
					engine.retract(f);
				}
			} catch (JessException e) {
				// TODO Auto-generated catch block
				System.out.println("Error while removing facts for user");
				System.out.println(e.getMessage());
			}
    		
		}
	}

}

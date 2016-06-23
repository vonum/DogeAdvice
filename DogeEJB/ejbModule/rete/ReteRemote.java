package rete;

import javax.ejb.Remote;

import jess.Fact;
import jess.JessException;

@Remote
public interface ReteRemote {
	
	public void listFacts();
	
	public void assertInitialFact(String sessionId, String category);
	
	public void assertFactFor(String sessionId, String symptom, boolean response);
	
	public void removeFactsForUser(String sessionId);
	
	public Object fetchObject(String name);
}

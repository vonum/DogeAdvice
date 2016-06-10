package rete;

import javax.ejb.Remote;

import jess.Fact;
import jess.JessException;

@Remote
public interface ReteRemote {

	public void test();
	
	public void listFacts();
	
	public void assertFact(String sessionId);
	
	public void assertFactFor(String sessionId, boolean response);
	
	public Object fetchObject(String name);
}

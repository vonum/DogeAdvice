package rete;

import javax.ejb.Remote;

@Remote
public interface ReteRemote {

	public void test();
	
	public void listFacts();
	
	public void assertFact(String sessionId);
}

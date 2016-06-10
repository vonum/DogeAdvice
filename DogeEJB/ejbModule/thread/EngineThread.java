package thread;

import jess.JessException;
import jess.Rete;

public class EngineThread extends Thread {
	
	private Rete engine;
	
	public EngineThread(Rete engine)
	{
		super();
		this.engine = engine;
	}
	
	public void run()
	{
		try {
			engine.runUntilHalt();
		} catch (JessException e) {
			// TODO Auto-generated catch block
			System.out.println("Error while running jess engine");
			e.getMessage();
		}
	}

}

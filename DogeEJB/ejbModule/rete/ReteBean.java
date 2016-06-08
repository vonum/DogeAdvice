package rete;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import jess.JessException;
import jess.Rete;

/**
 * Session Bean implementation class ReteBean
 */
@Stateless
@LocalBean
public class ReteBean implements ReteRemote {

	private Rete engine;
    /**
     * Default constructor. 
     */
    public ReteBean() {
        // TODO Auto-generated constructor stub
    	engine = new Rete();
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

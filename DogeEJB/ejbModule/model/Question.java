package model;

public class Question {

	private String name;
	
	private String text;
	
	public Question() {}
	
	public Question(String name, String text)
	{
		this.name = name;
		this.text = text;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
}

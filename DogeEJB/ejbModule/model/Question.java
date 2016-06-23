package model;

public class Question {

	private String name;
	
	private String text;
	
	private String type; //da li je simptom ili lokalizacija...
	
	public Question() {}
	
	public Question(String type, String name, String text)
	{
		this.type = type;
		this.name = name;
		this.text = text;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

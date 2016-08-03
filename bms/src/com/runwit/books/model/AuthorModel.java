package com.runwit.books.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class AuthorModel implements Serializable{
	private int authorId;
	private String firstName;
	private String lastName;
	
	public AuthorModel(int authorId, String firstName, String lastName) {
		super();
		this.authorId = authorId;
		this.firstName = firstName;
		this.lastName = lastName;
	}
	public AuthorModel() {
		// TODO Auto-generated constructor stub
	}
	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}
	public int getAuthorId() {
		return authorId;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getLastName() {
		return lastName;
	}
}

package com.runwit.books.model;

import java.io.Serializable;
import java.util.Arrays;

public class TitleModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String isbn;

	private String title; // 书名

	private int publisherId;

	private String publisherName;

	private double price;

	private String copyright;

	private int editionNumber;

	private int[] authorIds;
	
	private String imageFile;

	public int[] getAuthorIds() {
		return authorIds;
	}

	public void setAuthorIds(int[] authorIds) {
		this.authorIds = authorIds;
	}

	public String getCopyright() {
		return copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public int getEditionNumber() {
		return editionNumber;
	}

	public void setEditionNumber(int editionNumber) {
		this.editionNumber = editionNumber;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getPublisherId() {
		return publisherId;
	}

	public void setPublisherId(int publisherId) {
		this.publisherId = publisherId;
	}

	public String getPublisherName() {
		return publisherName;
	}

	public void setPublisherName(String publisherName) {
		this.publisherName = publisherName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getImageFile() {
		return imageFile;
	}
	
	public void setImageFile(String imageFile) {
		this.imageFile = imageFile;
	}
	
	@Override
	public String toString() {
		String sepLine = "<br>";
		StringBuffer sb = new StringBuffer();
		sb.append("isbn:"+isbn);
		sb.append(sepLine);
		sb.append("title:"+title);
		sb.append(sepLine);
		sb.append("price:"+price);
		sb.append(sepLine);
		sb.append("imageFile:"+imageFile);
		sb.append(sepLine);
		sb.append("publisherId:"+publisherId);
		sb.append(sepLine);
		sb.append("publisherName:"+publisherName);
		sb.append(sepLine);
		sb.append("copyright:"+copyright);
		sb.append(sepLine);
		sb.append("edition number:"+editionNumber);
		sb.append(sepLine);
		sb.append("author list:");
		sb.append(sepLine);
		sb.append(Arrays.toString(authorIds));
		return sb.toString();
		
	}
}

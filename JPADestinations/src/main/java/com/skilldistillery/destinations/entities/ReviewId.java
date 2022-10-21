package com.skilldistillery.destinations.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ReviewId implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "destination_id")
	private int destinationId;

	@Column(name = "user_id")
	private int userId;

	public ReviewId() {
	}

	public ReviewId(int destinationId, int userId) {
		super();
		this.destinationId = destinationId;
		this.userId = userId;
	}

	public int getDestinationId() {
		return destinationId;
	}

	public void setDestinationId(int destinationId) {
		this.destinationId = destinationId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(destinationId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReviewId other = (ReviewId) obj;
		return destinationId == other.destinationId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "ReviewId [destinationId=" + destinationId + ", userId=" + userId + "]";
	}

}

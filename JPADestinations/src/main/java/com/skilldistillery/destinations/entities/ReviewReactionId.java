package com.skilldistillery.destinations.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ReviewReactionId implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "user_id")
	private int userId;

	@Column(name = "review_destination_id")
	private int reviewDestinationId;

	@Column(name = "review_user_id")
	private int reviewUserId;

	public ReviewReactionId() {}

	public ReviewReactionId(int userId, int reviewDestinationId, int reviewUserId) {
		super();
		this.userId = userId;
		this.reviewDestinationId = reviewDestinationId;
		this.reviewUserId = reviewUserId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getReviewDestinationId() {
		return reviewDestinationId;
	}

	public void setReviewDestinationId(int reviewDestinationId) {
		this.reviewDestinationId = reviewDestinationId;
	}

	public int getReviewUserId() {
		return reviewUserId;
	}

	public void setReviewUserId(int reviewUserId) {
		this.reviewUserId = reviewUserId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(reviewDestinationId, reviewUserId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReviewReactionId other = (ReviewReactionId) obj;
		return reviewDestinationId == other.reviewDestinationId && reviewUserId == other.reviewUserId
				&& userId == other.userId;
	}

	@Override
	public String toString() {
		return "ReviewReactionId [userId=" + userId + ", reviewDestinationId=" + reviewDestinationId + ", reviewUserId="
				+ reviewUserId + "]";
	}

	
	

}
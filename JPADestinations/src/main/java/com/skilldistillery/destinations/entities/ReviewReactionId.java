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

	private ReviewId reviewId;

	public ReviewReactionId() {
	}

	public ReviewReactionId(int userId, ReviewId reviewId) {
		super();
		this.userId = userId;
		this.reviewId = reviewId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public ReviewId getReviewId() {
		return reviewId;
	}

	public void setReviewId(ReviewId reviewId) {
		this.reviewId = reviewId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(reviewId, userId);
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
		return Objects.equals(reviewId, other.reviewId) && userId == other.userId;
	}

	@Override
	public String toString() {
		return "ReviewReactionId [userId=" + userId + ", reviewId=" + reviewId + "]";
	}

}

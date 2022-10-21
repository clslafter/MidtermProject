package com.skilldistillery.destinations.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "review_reaction")
public class ReviewReaction {

	@EmbeddedId
	private ReviewReactionId id;

	private boolean reaction;

	@Column(name = "reaction_date")
	private LocalDateTime reactionDate;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	@MapsId(value="userId")
	private User user;
	
	@ManyToOne
	@JoinColumns({
		@JoinColumn(name="review_destination_id", referencedColumnName ="destination_id"),
		@JoinColumn(name="review_user_id", referencedColumnName ="user_id")
	})
	@MapsId(value="reviewId")
	private Review review;
	
	//METHODS

	public ReviewReaction() {
	}

	public ReviewReactionId getId() {
		return id;
	}

	public void setId(ReviewReactionId id) {
		this.id = id;
	}

	public boolean isReaction() {
		return reaction;
	}

	public void setReaction(boolean reaction) {
		this.reaction = reaction;
	}

	public LocalDateTime getReactionDate() {
		return reactionDate;
	}

	public void setReactionDate(LocalDateTime reactionDate) {
		this.reactionDate = reactionDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReviewReaction other = (ReviewReaction) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "ReviewReaction [id=" + id + ", reaction=" + reaction + ", reactionDate=" + reactionDate + "]";
	}

}

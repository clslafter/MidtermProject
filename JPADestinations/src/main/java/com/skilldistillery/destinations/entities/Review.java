package com.skilldistillery.destinations.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;

@Entity
public class Review {

	@EmbeddedId
	private ReviewId id;

	private String comment;

	private int rating;

	@Column(name = "image_url")
	private String imageUrl;

	@Column(name = "review_date")
	private LocalDateTime reviewDate;

	private boolean enabled;
	
	@OneToMany(mappedBy="review")
	private List <ReviewComment> reviewComments;
	
	@OneToMany(mappedBy="review")
	private List <ReviewReaction> reviewReactions;
	
	@ManyToOne
	@JoinColumn(name="destination_id")
	@MapsId(value="destinationId")
	private Destination destination;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	@MapsId(value="userId")
	private User user;
	
	//METHODS

	public Review() {
	}

	public ReviewId getId() {
		return id;
	}

	public void setId(ReviewId id) {
		this.id = id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public LocalDateTime getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(LocalDateTime reviewDate) {
		this.reviewDate = reviewDate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public List<ReviewComment> getReviewComments() {
		return reviewComments;
	}

	public void setReviewComments(List<ReviewComment> reviewComments) {
		this.reviewComments = reviewComments;
	}

	public void addReviewComment(ReviewComment reviewComment) {
		if (reviewComments == null)
			reviewComments = new ArrayList<>();
		if (!reviewComments.contains(reviewComment)) {
			reviewComments.add(reviewComment);
			if (reviewComment.getReview() != null) {
				reviewComment.getReview().getReviewComments().remove(reviewComment);
			}
			reviewComment.setReview(this);
		}
	}
	
	public void removeReviewComment(ReviewComment reviewComment) {
		if (reviewComments != null) {
			reviewComments.remove(reviewComment);
			reviewComment.setReview(null);
		}
	}
	
	public List<ReviewReaction> getReviewReactions() {
		return reviewReactions;
	}

	public void setReviewReactions(List<ReviewReaction> reviewReactions) {
		this.reviewReactions = reviewReactions;
	}

	public void addReviewReaction(ReviewReaction reviewReaction) {
		if (reviewReactions == null)
			reviewReactions = new ArrayList<>();
		if (!reviewReactions.contains(reviewReaction)) {
			reviewReactions.add(reviewReaction);
			if (reviewReaction.getReview() != null) {
				reviewReaction.getReview().getReviewReactions().remove(reviewReaction);
			}
			reviewReaction.setReview(this);
		}
	}
	
	public void removeReviewReaction(ReviewReaction reviewReaction) {
		if (reviewReactions != null) {
			reviewReactions.remove(reviewReaction);
			reviewReaction.setReview(null);
		}
	}
	
	public Destination getDestination() {
		return destination;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
		Review other = (Review) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "Review [id=" + id + ", comment=" + comment + ", rating=" + rating + ", imageUrl=" + imageUrl
				+ ", reviewDate=" + reviewDate + ", enabled=" + enabled + "]";
	}

}

package com.skilldistillery.destinations.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "review_comment")
public class ReviewComment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String comment;

	@Column(name = "created_date")
	private LocalDateTime createdDate;

	private boolean enabled;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="in_reply_to_id")
	private ReviewComment reviewComment;
	
	@OneToMany(mappedBy="reviewComment")
	private List <ReviewComment> reviewComments;
	
	@ManyToOne
	@JoinColumns({
		@JoinColumn(name="review_destination_id", referencedColumnName ="destination_id"),
		@JoinColumn(name="review_user_id", referencedColumnName ="user_id")
	})
	private Review review;
	
	
	//METHODS

	public ReviewComment() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ReviewComment getReviewComment() {
		return reviewComment;
	}

	public void setReviewComment(ReviewComment reviewComment) {
		this.reviewComment = reviewComment;
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
			if (reviewComment.getReviewComment() != null) {
				reviewComment.getReviewComment().getReviewComments().remove(reviewComment);
			}
			reviewComment.setReviewComment(this);
		}
	}

	public void removeReviewComment(ReviewComment reviewComment) {
		if (reviewComments != null) {
			reviewComments.remove(reviewComment);
			reviewComment.setReviewComment(null);
		}
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
		ReviewComment other = (ReviewComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ReviewComment [id=" + id + ", comment=" + comment + ", createdDate=" + createdDate + ", enabled="
				+ enabled + "]";
	}

}

package com.skilldistillery.destinations.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "review_reaction")
public class ReviewReaction {

	@EmbeddedId
	private ReviewReactionId id;

	private boolean reaction;

	@Column(name = "reaction_date")
	private LocalDateTime reactionDate;

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

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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "destination_comment")
public class DestinationComment {

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
	@JoinColumn(name="destination_id")
	private Destination destination;
	
	@ManyToOne
	@JoinColumn(name="in_reply_to_id")
	private DestinationComment destinationComment;
	
	@OneToMany(mappedBy="destinationComment")
	private List <DestinationComment> destinationComments;
	
	//METHODS

	public DestinationComment() {
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

	public Destination getDestination() {
		return destination;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
	}

	public DestinationComment getDestinationComment() {
		return destinationComment;
	}

	public void setDestinationComment(DestinationComment destinationComment) {
		this.destinationComment = destinationComment;
	}

	public List<DestinationComment> getDestinationComments() {
		return destinationComments;
	}

	public void setDestinationComments(List<DestinationComment> destinationComments) {
		this.destinationComments = destinationComments;
	}

	public void addDestinationComment(DestinationComment destinationComment) {
		if (destinationComments == null)
			destinationComments = new ArrayList<>();
		if (!destinationComments.contains(destinationComment)) {
			destinationComments.add(destinationComment);
			if (destinationComment.getDestinationComment() != null) {
				destinationComment.getDestinationComment().getDestinationComments().remove(destinationComment);
			}
			destinationComment.setDestinationComment(this);
		}
	}

	public void removeDestinationComment(DestinationComment destinationComment) {
		if (destinationComments != null) {
			destinationComments.remove(destinationComment);
			destinationComment.setDestinationComment(null);
		}
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
		DestinationComment other = (DestinationComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "DestinationComment [id=" + id + ", comment=" + comment + ", createdDate=" + createdDate + ", enabled="
				+ enabled + "]";
	}

}

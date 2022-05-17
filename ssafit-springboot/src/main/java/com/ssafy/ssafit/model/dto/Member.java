package com.ssafy.ssafit.model.dto;

public class Member {
	private int memberSeq;
	private String userId;
	private String password;
	private String username;

	public Member() {
	}

	public Member(int memberSeq, String userId, String password, String username) {
		this.memberSeq = memberSeq;
		this.userId = userId;
		this.password = password;
		this.username = username;
	}

	public int getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(int memberSeq) {
		this.memberSeq = memberSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return "Member [memberSeq=" + memberSeq + ", userId=" + userId + ", password=" + password + ", username="
				+ username + "]";
	}

}

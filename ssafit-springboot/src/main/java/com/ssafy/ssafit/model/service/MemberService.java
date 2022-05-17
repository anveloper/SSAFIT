package com.ssafy.ssafit.model.service;

import java.util.List;

import com.ssafy.ssafit.model.dto.Member;

public interface MemberService {
	public List<Member> getFollowList(String userId); // 내가 팔로우 하는 사람들
	
	public List<Member> getLeadList(String userId); // 나를 따르는 사람들

	public Member getMember(String userId);

	public void joinMember(Member member) throws Exception;

	public void updateMember(Member member) throws Exception;

	public void deleteMember(String userId);

}

package com.ssafy.ssafit.model.dao;

import java.util.HashMap;
import java.util.List;

import com.ssafy.ssafit.model.dto.Member;

public interface MemberDao {
	public List<Member> selectFollowList(String userId); // follow list, password 제외

	public List<Member> selectLeadList(String userId); // lead list, password 제외

	public Member selectMember(String userId);

	public void insertMember(Member member) throws Exception;

	public void updateMember(Member member) throws Exception;

	public void deleteMember(String userId);

	public void followId(HashMap<String, String> params);

	public void unFollowId(HashMap<String, String> params);

	public Member selectMemberByName(String username);

}

package com.ssafy.ssafit.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.MemberDao;
import com.ssafy.ssafit.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public List<Member> getFollowList(String userId) {
		return memberDao.selectFollowList(userId);
	}

	@Override
	public List<Member> getLeadList(String userId) {
		return memberDao.selectLeadList(userId);
	}

	@Override
	public Member getMember(String userId) {
		return memberDao.selectMember(userId);
	}

	@Override
	public void joinMember(Member member) throws Exception {
		memberDao.insertMember(member);
	}

	@Override
	public void updateMember(Member member) throws Exception {
		memberDao.updateMember(member);
	}

	@Override
	public void deleteMember(String userId) {
		memberDao.deleteMember(userId);
	}

	@Override
	public void followId(HashMap<String, String> params) {
		memberDao.followId(params);
	}

	@Override
	public void unFollowId(HashMap<String, String> params) {
		memberDao.unFollowId(params);
	}

	@Override
	public Member getMemberByName(String username) {		
		return memberDao.selectMemberByName(username);
	}

}

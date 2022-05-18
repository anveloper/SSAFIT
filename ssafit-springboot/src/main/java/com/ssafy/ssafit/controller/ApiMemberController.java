package com.ssafy.ssafit.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ssafit.exception.PWIncorrectException;
import com.ssafy.ssafit.exception.UserNotFoundException;
import com.ssafy.ssafit.model.dto.Member;
import com.ssafy.ssafit.model.service.MemberService;
import com.ssafy.ssafit.util.JWTUtil;

@RestController
@RequestMapping("/member")
public class ApiMemberController {
	private static final String SUCESS = "sucess";
	private static final String FAIL = "fail";
	private static final String HEADER_AUTH = "auth-token";

	@Autowired
	private MemberService memberService;

	@Autowired
	private JWTUtil jwtUtil;

	@PostMapping("/login")
	public ResponseEntity<Map<String, Object>> login(@RequestBody Member member) {
		HttpStatus status = null;
		HashMap<String, Object> result = new HashMap<>();

		try {
			// user 정보 DB확인
			if (member.getUserId() != null || member.getUserId().length() > 0) {
				Member m = memberService.getMember(member.getUserId());
				System.out.println(m.getUserId());
				if (m.getUserId().equals(""))
					throw new UserNotFoundException();
				if (!member.getPassword().equals(m.getPassword()))
					throw new PWIncorrectException();

				result.put("auth-token", jwtUtil.createToken("userId", member.getUserId()));
				result.put("msg", SUCESS);
				result.put("logonMember", memberService.getMember(member.getUserId()));
				status = HttpStatus.ACCEPTED;
			} else {
				result.put("msg", FAIL);
				status = HttpStatus.UNAUTHORIZED; // 권한없음
			}
		} catch (UserNotFoundException e) {
			e.printStackTrace();
			status = HttpStatus.UNAUTHORIZED;
		} catch (PWIncorrectException e) {
			e.printStackTrace();
			status = HttpStatus.UNAUTHORIZED;
		} catch (Exception e) {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(result, status);
	}

	@GetMapping("/{userId}")
	public ResponseEntity<Map<String, Object>> getMember(@PathVariable String userId) {
		HttpStatus status = null;
		HashMap<String, Object> result = new HashMap<>();

		try {
			result.put("logonMember", memberService.getMember(userId));
			result.put("followList", memberService.getFollowList(userId));
			result.put("leadList", memberService.getLeadList(userId));
			status = HttpStatus.OK;
		} catch (Exception e) {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}

		return new ResponseEntity<Map<String, Object>>(result, status);
	}

	@PostMapping("/join")
	public ResponseEntity<Member> join(@RequestBody Member member) {
		HttpStatus status = null;
		try {
			memberService.joinMember(member);
			status = HttpStatus.CREATED;
			member = null; // 정보는 제거하고, 로그인 페이지로 이동
		} catch (Exception e) {
			status = HttpStatus.CONFLICT; // 정보를 들고 다시 join으로 이동
		}
		return new ResponseEntity<Member>(member, status);
	}

	@PutMapping("/{userId}")
	public ResponseEntity<Member> update(@PathVariable String userId, @RequestBody Member member,
			HttpServletRequest req) {
		HttpStatus status = null;
		String token = req.getHeader(HEADER_AUTH);
		try {
			if (jwtUtil.getTokenId(token).equals(userId)) {
				System.out.println(member);
				memberService.updateMember(member);
				status = HttpStatus.CREATED; // 수정 완료
			} else
				status = HttpStatus.CONFLICT;
		} catch (Exception e) {
			status = HttpStatus.CONFLICT; //
		}
		return new ResponseEntity<Member>(memberService.getMember(userId), status);
	} // memberSeq가 반드시 담겨있어야 함.

	@DeleteMapping("/{userId}")
	public ResponseEntity<String> delete(@PathVariable String userId, HttpServletRequest req) {
		HttpStatus status = null;
		String token = req.getHeader(HEADER_AUTH);
		try {
			if (jwtUtil.getTokenId(token).equals(userId)) {
				memberService.deleteMember(userId);
				status = HttpStatus.NO_CONTENT;
			} else
				status = HttpStatus.CONFLICT;
		} catch (Exception e) {
			status = HttpStatus.CONFLICT;
		}
		return new ResponseEntity<String>("deleted : " + userId, status);
	}

	@GetMapping("/follow/{userId}")
	public ResponseEntity<String> follow(@PathVariable String userId, HttpServletRequest req) {
		HttpStatus status = null;
		String token = req.getHeader(HEADER_AUTH);
		HashMap<String, String> params = new HashMap<>();
		params.put("userId", userId);
		try {
			String myId = jwtUtil.getTokenId(token);
			params.put("myId", myId);
			memberService.followId(params);
			status = HttpStatus.CREATED;
		} catch (Exception e) {
			status = HttpStatus.CONFLICT;
		}

		return new ResponseEntity<String>("", status);
	}

	@DeleteMapping("/follow/{userId}")
	public ResponseEntity<String> unfollow(@PathVariable String userId, HttpServletRequest req) {
		HttpStatus status = null;
		String token = req.getHeader(HEADER_AUTH);
		HashMap<String, String> params = new HashMap<>();
		params.put("userId", userId);
		try {
			String myId = jwtUtil.getTokenId(token);
			params.put("myId", myId);
			memberService.unFollowId(params);
			status = HttpStatus.NO_CONTENT;
		} catch (Exception e) {
			status = HttpStatus.CONFLICT;
		}

		return new ResponseEntity<String>("", status);
	}
}

package com.wtoon.webtoon.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtoon.webtoon.member.model.dao.MemberDao;
import com.wtoon.webtoon.member.model.dto.Member;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Transactional
	public int insertMember_BCrypt(Member m) {
		return memberDao.insertMember(m);
	}

	public Member selectOneMember_BCrypt(Member m) {
		/*
		Member selectedMember = memberDao.selectOneMember(m);
		if(m!=null && bCryptPasswordEncoder.matches(m.getMemberPw(), selectedMember.getMemberPw())) {
			return selectedMember;
		}else {
			return null;
		}
		*/
		return memberDao.selectOneMember(m);
	}

	public Member checkPhone(int memberPhone) {
		return memberDao.checkPhone(memberPhone);
	}

	public Member checkNickname(String memberNickname) {
		return memberDao.checkNickname(memberNickname);
	}
	
	
	
	
}

package com.wtoon.webtoon.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtoon.webtoon.member.model.dto.Member;

@Repository
public class MemberDao {

	@Autowired
	private SqlSessionTemplate session;

	public int insertMember(Member m) {
		return session.insert("member.insertMember", m);
	}

	public Member selectOneMember(Member m) {
		return session.selectOne("member.selectOneMember", m);
	}

	public Member checkPhone(int memberPhone) {
		return session.selectOne("member.checkPhone", memberPhone);
	}

	
	
}

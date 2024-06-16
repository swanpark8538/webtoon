<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="<c:url value="/resources/css/font.css" />" >
	<link rel="stylesheet" href="<c:url value="/resources/css/reset.css" />" >
	<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />" >
	<link rel="stylesheet" href="<c:url value="/resources/css/main.css" />" >
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
	<script src="<c:url value="/resources/js/jquery-3.6.0.js" />" ></script>
</head>
<body>

	<div class="wrap">
	
		<header id="header">
	        <div class="header_inner">
	            <h1 class="logo"><a href="/"><span class="hidden">Wtoon</span></a></h1>
	            <form class="header_search_form" action="/" method="get">
	                <div class="input_item">
	                    <input type="search" name="keyword" placeholder="제목/작가를 검색해보세요">
	                    <button type="submit" class="btn_search"><span class="hidden">검색</span></button>
	                </div>
	            </form>
	            <div class="user_menu_area">
            		<c:if test="${empty sessionScope.member }">
		                <ul>
		                    <li><a href="/member/signUpFrm">회원가입</a></li>
		                    <li><a href="/member/signInFrm">로그인</a></li>
		                </ul>
            		</c:if>
            		<c:if test="${not empty sessionScope.member }">
            			<ul>
		                    <li><a href="#">마이페이지</a></li>
		                    <li><a href="/member/signOut">로그아웃</a></li>
		                </ul>
            		</c:if>
	            </div>
	        </div>
	    </header>
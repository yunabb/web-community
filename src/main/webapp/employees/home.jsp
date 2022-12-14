<%@page import="com.community.vo.Bell"%>
<%@page import="com.community.dao.BellDao"%>
<%@page import="com.community.dao.ReviewDao"%>
<%@page import="com.community.vo.Review"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.vo.Question"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.StoryPostDao"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Position"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@page import="com.community.vo.Department"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/logincheck.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link href="/web-community/resources/css/style.css" rel="stylesheet">
<title>사내 커뮤니티</title>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="employee"/>
</jsp:include>
<%
	
	DepartmentDao deptDao = new DepartmentDao();
	PositionDao posDao = new PositionDao();
	PostDao postDao = PostDao.getInstance();
	ReviewDao reviewDao = ReviewDao.getInstance();
	
	int myPostRows = postDao.getTotalRowsByEmpno(loginedEmp.getEmpNo());
	int myCommentRows = reviewDao.getTotalRows(loginedEmp.getEmpNo());
	
	Department dept = deptDao.getNameByEmpNo(loginedEmp.getEmpNo());
	Position pos = posDao.getNameByEmpNo(loginedEmp.getEmpNo());	

%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">내 정보 보기</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card">
				<div class="card-header">나의 메뉴</div>
				<div class="card-body">
					<div class="list-group">
						<a href="home.jsp" class="list-group-item list-group-item-action">내 정보 보기</a>
						<a href="myposts.jsp" class="list-group-item list-group-item-action">내가 작성한 게시글</a>
						<a href="mycomments.jsp"  class="list-group-item list-group-item-action">내가 작성한 댓글</a>
						<a href="mybells.jsp" class="list-group-item list-group-item-action">나에게 온 알림</a>
					</div>
				</div>
				<div class="card-body">
					<div class="list-group">
						<a href="passwordform.jsp" class="list-group-item list-group-item-action">비밀번호 변경하기</a>
					</div>
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="row mb-3">
				<div class="col-12">
					<p>내 정보를 확인하세요</p>
					<table class="table table-bordered">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th class="bg-light">직원번호</th><td><%=loginedEmp.getEmpNo() %></td>
								<th class="bg-light">입사일</th><td><%=StringUtils.dateToText(loginedEmp.getCreatedDate()) %></td>
							</tr>
							<tr>
								<th class="bg-light">소속부서</th><td><%=dept.getName() %></td>
								<th class="bg-light">직위</th><td><%=pos.getName() %></td>
							</tr>
							<tr>
								<th class="bg-light">이름</th><td colspan="3"><%=loginedEmp.getName() %></td>
							</tr>
							<tr>
								<th class="bg-light">연락처</th><td><%=loginedEmp.getPhone() %></td>
								<th class="bg-light">이메일</th><td><%=loginedEmp.getEmail() %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row mb-3" id="myinfo">
				<div class="col-12">
					<div class="card">
						<div class="card-header">내 정보</div>
						<div class="card-body">
							<div class="row p-3">
								<div class="col-4">
								<div class="card">
									<div class="card-body bg-primary text-white text-bold">
										<h5>내가 작성한 글</h5>
										<small>내가 작성한 글은 <strong><%=myPostRows %>개</strong> 입니다.</small>
									</div>
								</div>
								</div>
								<div class="col-4">
									<div class="card">
										<div class="card-body bg-success text-white text-bold">
											<h5>내가 작성한 댓글</h5>
											<small>내가 작성한 댓글은 <strong><%=myCommentRows %>개</strong> 입니다.</small>
										</div>
									</div>
								</div>
	<%
		Employee emp = (Employee) session.getAttribute("loginedEmp");
	
		BellDao bellDao = BellDao.getInstance();
		int bell = bellDao.getBellsRows(emp.getEmpNo());
	%>
								<div class="col-4">
									<div class="card">
										<div class="card-body bg-danger text-white text-bold">
											<h5>나에게 온 알림</h5>
											<small>나에게 온 알림은 <strong><%=bell %>개</strong> 입니다.</small>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>
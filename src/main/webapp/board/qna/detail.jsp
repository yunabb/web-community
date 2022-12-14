<%@page import="java.sql.SQLException"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.vo.Reading"%>
<%@page import="com.community.dao.ReadingDao"%>
<%@page import="java.util.List"%>
<%@page import="com.community.vo.Review"%>
<%@page import="com.community.dao.ReviewDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<jsp:include page="../../common/header.jsp">
	<jsp:param name="menu" value="board"/>
</jsp:include>

<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">게시글 상세정보</h1>
		</div>
	</div>
	
	<%
		int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	
		ReadingDao readingDao = ReadingDao.getInstance();
		try {
			Reading reading = new Reading();
			reading.setPost(new Post(postNo));
			reading.setEmployee(new Employee(emp.getEmpNo()));
			readingDao.insertReading(reading);
		} catch (Exception e) {
		}
		 
		QuestionDao questionDao = QuestionDao.getInstance();
		Question question = questionDao.getQuestionByNo(postNo);
	
		question.setReadCount(question.getReadCount() + 1);
		questionDao.updateQuestion(question);
		
	%>
	
	<div class="row mb-3">
		<div class="col-12">
			<table class="table table-sm table-bordered">
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
				<tbody>
					<tr>
						<th class="text-center bg-light">번호</th>
						<td><%=question.getPostNo() %></td>
						<th class="text-center bg-light">등록일</th>
						<td><%=StringUtils.dateToText(question.getCreatedDate()) %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">제목</th>
						<td><%=question.getTitle() %></td>
						<th class="text-center bg-light">추천수</th>
						<td><%=question.getSuggestionCount() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">작성자</th>
						<td><%=question.getEmployee().getName() %> (<%=question.getPosition().getName() %>)</td>
						<th class="text-center bg-light">소속부서</th>
						<td><%=question.getDepartment().getName() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">조회수</th>
						<td><%=question.getReadCount() %></td>
						<th class="text-center bg-light">댓글 수</th>
						<td><%=question.getCommentCount() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">내용</th>
						<td colspan="3"><textarea rows="4" class="form-control border-0" readonly><%=question.getContent() %></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="d-flex justify-content-between">
				<span>
					<a href="list.jsp" class="btn btn-success btn-xs" >목록</a>
				
	<%
		if(emp != null && emp.getName().equals(question.getEmployee().getName())) {
	%>			
					<a href="delete.jsp?postNo=<%=question.getPostNo() %>" class="btn btn-danger btn-xs">삭제</a>
					<a href="" class="btn btn-warning btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">수정</a>
	<%
		}
	%>				
	
				</span>
				<span>
				
	<%
		if(emp == null || emp.getName().equals(question.getEmployee().getName())) {
	%>				
					<a href="suggestion.jsp?postNo=<%=question.getPostNo() %>" class="btn btn-outline-primary btn-xs disabled">추천<%=question.getSuggestionCount() %></a>
					<button class="btn btn-outline-primary btn-xs disabled">답변</button>
	<%
		} else{
	%>			
					<a href="suggestion.jsp?postNo=<%=question.getPostNo() %>" class="btn btn-outline-primary btn-xs">추천<%=question.getSuggestionCount() %></a>
					<button class="btn btn-outline-primary btn-xs">답변</button>
	<%
		}
	%>		
				</span>
			</div>
		</div>
	</div>
	
	<div class="row mb-3">
	<%
		if(emp != null) {
	%>
		<div class="col-12 mb-1">
			<form method="post" action="addReview.jsp">
				<!-- 게시글의 글 번호을 value에 설정하세요 -->
				<input type="hidden" name="postNo" value="<%=question.getPostNo() %>"/>
				<div class="row mb-3">
					<div class="col-sm-11">
						<input type="text" class="form-control form-control-sm" name="content" placeholder="댓글을 남겨주세요">
					</div>
					<div class="col-sm-1 text-end" style="margin-top: 2px;">
						<button class="btn btn-secondary btn-xs" id="submitButton">댓글</button>
					</div>
				</div>
			</form>
		</div>
	<%
		} else {
	%>
		<div class="col-12 mb-1">
			<form method="post" action="addReview.jsp?">
				<!-- 게시글의 글 번호을 value에 설정하세요 -->
				<input type="hidden" name="postNo" value="<%=question.getPostNo() %>" />
				<div class="row mb-3">
					<div class="col-sm-11">
						<input type="text" class="form-control form-control-sm" name="content" placeholder="댓글을 남겨주세요" disabled />
					</div>
					<div class="col-sm-1 text-end" style="margin-top: 2px;">
						<button class="btn btn-secondary btn-xs disabled">댓글</button>
					</div>
				</div>
			</form>
		</div>
	<%
		}
	%>
		
	<%
		ReviewDao reviewDao = ReviewDao.getInstance();
		List<Review> reviewList = reviewDao.getReviewsByPostNo(postNo);
	%>	
		<div class="col-12">
			<div class="card">
				<!-- 댓글 반복 시작 -->
	<%
		for(Review review : reviewList) {
	%>				
				<div class="card-body py-1 px-3 small border-bottom">
					<div class="mb-1 d-flex justify-content-between text-muted">
						<span><%=review.getEmployee().getName() %></span>
						<span><span class="me-4"><%=review.getCreatedDate() %></span> <a href="deleteReview.jsp?postNo=<%=question.getPostNo() %>&reviewNo=<%=review.getReviewNo() %>" class="text-danger"><i class="bi bi-trash-fill"></i></a></span>
					</div>
					<p class="card-text"><%=review.getContent() %></p>
				</div>
	<%
		}
	%>				
				<!-- 댓글 반복 끝 -->
			</div>				
		</div>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-posts">
	<div class="modal-dialog modal-lg">
	<form class="border p-3 bg-light" method="post" action="modify.jsp">
		<!-- 게시글의 글 번호을 value에 설정하세요 -->
		<input type="hidden" name="postNo" value="1000"/>
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">게시글 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">게시판 이름</label>
						<div class="col-sm-5">
							<select class="form-select form-select-sm">
								<option value="100"> 공지사항</option>
								<option value="100"> 파일게시판</option>
								<option value="100"> 갤러리</option>
								<option value="100"> 묻고 답하기</option>
								<option value="100"> 벼룩시장</option>
								<option value="100"> 사는 얘기</option>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" placeholder="제목">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" readonly="readonly" value="홍길동">
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-sm-8 offset-sm-2">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="" value="N" checked>
								<label class="form-check-label">일반</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="" value="Y" >
								<label class="form-check-label">중요</label>
							</div>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">내용</label>
						<div class="col-sm-10">
							<textarea rows="5" class="form-control">내용을 수정하세요</textarea>
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">수정</button>
			</div>
		</div>
	</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul class="tree border py-3 text-dark">
	<%
		String menu = request.getParameter("menu");
	%>
	<li>
		<span class="caret"><a href="/web-community/board/notice/list.jsp" class="text-decoration-none text-dark <%="board".equals(menu) ? "active bg-danger" : "" %>">공지사항</a></span>
		<!-- 
		<ul class="nested active">
			<li><a href="/web-community/board/notice/form.jsp" class="text-decoration-none text-dark">공지사항 추가</a></li>
		</ul>
		 -->
		
	</li>
	<li>
		<span class="caret"><a href="/web-community/board/file/list.jsp" class="text-decoration-none text-dark <%="board".equals(menu) ? "active bg-danger" : "" %>">파일게시판</a></span>
	</li>
	<li>
		<span class="caret caret-down"><a class="text-decoration-none text-dark">자유게시판</a></span>
 		<ul class="nested active">
			<li><a href="/web-community/board/qna/list.jsp" class="text-decoration-none text-dark <%="board".equals(menu) ? "active bg-danger" : "" %>">묻고 답하기</a></li>
			<li><a href="/web-community/board/story/list.jsp" class="text-decoration-none text-dark <%="board".equals(menu) ? "active bg-danger" : "" %>">사는 이야기</a></li>
		</ul>
	</li>
	<li>
		<span class="caret"><a href="/web-community/board/temp/list.jsp" class="text-decoration-none text-dark">임시게시판</a></span>
	</li>
</ul>
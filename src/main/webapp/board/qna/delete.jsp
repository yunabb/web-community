<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../../common/logincheck.jsp" %>
<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");

	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));

	QuestionDao questionDao = QuestionDao.getInstance();
	Question question = questionDao.getQuestionByNo(postNo);
	
	if(emp.getEmpNo() != question.getEmployee().getEmpNo()) {
		response.sendRedirect("list.jsp");
		return;
	}
	
	question.setDeleted("Y");
	
	questionDao.updateQuestion(question);
	
	response.sendRedirect("list.jsp");
%>
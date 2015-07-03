<%@ page import="java.util.Map"%>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<title>Report Class</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Expires" content="0">
<meta http-equiv="Pragma" content="no-cache">
</head>

<%@include file= "../../include/CrystalReportHelper.jsp"%>

<body>
	
	<%!private final String reportName = "employee_task.rpt";%>
	<%
		try {
			ReportClientDocument clientDoc = getClientDocument(reportName);
			try {
				setDocParameter(0, (String)session.getAttribute("searchQuery"), clientDoc);
				setDocParameter(1, (String)session.getAttribute("searchQuery1"), clientDoc);
				setDocParameter(2, (String)session.getAttribute("searchQuery2"), clientDoc);
				setDocParameter(3, (String)session.getAttribute("searchQuery3"), clientDoc);
				setDocParameter(4, (String)session.getAttribute("searchQuery4"), clientDoc);
				setDocParameter(5, (String)session.getAttribute("searchQuery5"), clientDoc);
				setDocParameter(6, (String)session.getAttribute("searchQuery6"), clientDoc);
				setDocParameter(7, (String)session.getAttribute("searchQuery7"), clientDoc);
				viewReport(clientDoc, request, response, session);
			} finally {
				clientDoc.close();
				clientDoc.dispose();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	%>
</body>
</html>

			
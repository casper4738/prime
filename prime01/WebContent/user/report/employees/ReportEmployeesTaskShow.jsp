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
	
	<%!private final String reportName = "employee_task1.rpt";%>
	<%
		try {
			ReportClientDocument clientDoc = getClientDocument(reportName);
			try {
				setDocParameter(0, (String)session.getAttribute("searchQuery"), clientDoc); 
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

			
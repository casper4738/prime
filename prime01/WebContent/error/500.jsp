<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE HTML>
<html>
<head>
<title>500</title>
<meta name="keywords" />
<link href="resources/style-404.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<div class="wrap">
		<div class="header">
			<div class="logo"><h1>PRIME - Project Information Management System</h1></div>
		</div>
		<div class="content">
			<img src="resources/err500.png" title="error" />
			<p><span>Ohh.....</span>Your Page Not Found</p>
			<html:link action="Menu.do">Back To Home</html:link>
		</div>
	</div>
</body>
</html>


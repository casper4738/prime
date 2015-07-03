<%@page import="prime.constants.Constants"%>
<%@page import="prime.login.LoginData"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<title>PRIMEprogram</title>

	<!-- CSS -->
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	.info-modal .modal {
		position: relative;
		top: auto;
		bottom: auto;
		right: auto;
		left: auto;
		display: block;
		z-index: 1;
	}
	
	.info-modal .modal {
		background: transparent !important;
	}
	</style>
<!-- End CSS -->
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- Header -->
		<jsp:include page="Header.jsp"></jsp:include>
		

		<!-- Side Bar Menu -->
		<aside class="main-sidebar">
			<section class="sidebar">
				<div class="user-panel">
					<div class="pull-left image">
						<img id="profpic3" class="img-circle"
							alt="User Image" />
					</div>
					<div class="pull-left info">
						<p><%=LoginData.getEmployeeData().getEmployeeName()%></p>
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					</div>
				</div>
				<ul class="sidebar-menu">
					<li class="header">Main Navigation</li>
					
					<logic:iterate id="pageAction" name="listPages" indexId="count"
						scope="request">
						<li><a href="#"
							onclick="menuLoadHandler('${pageAction.key}')"><i
								class="fa fa-dashboard"></i> <span>${pageAction.value}</span></a></li>
					</logic:iterate>
				</ul>
			</section>
		</aside>

		<!-- Main Content -->
		<div class="content-wrapper" id="content-main"></div>

		<!-- Modal -->
		<div id="content-modal" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-body" id="content-modal-body">
						<p>Some text in the modal.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Footer -->
		<jsp:include page="Footer.jsp"></jsp:include>
	</div>
</body>

<!-- JS -->
	<script src="resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script src="resources/plugins/jQueryUI/jquery-ui-1.10.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/serialize/serialize-0.2.min.js" type="text/javascript"></script>
	<script src="resources/prime.js"></script>
	<script  type="text/javascript">
	   	$(document).ready(function(){
	   		$.ajaxSetup({ cache: false });
	   		
	   		refreshNotification();
	   		setInterval(refreshNotification, 300000); //5 Menit

<%-- 	   		sendNotification(100,  <%=Constants.NotificationType.PROJECT_CREATEAPPROVAL%>,  "<%=Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]%>;<%=Constants.Task.GOTOVIEW%>;5;100"); --%>
	   		
	   		//##0.Prepare Profile Picture
	   		var tmpImage = '<%=LoginData.getEmployeeData().getConvertedFilePic()%>';
	  	  	if(tmpImage == "null"){
	      		  $("#profpic1").attr("src", "<%=Constants.PATH_USERNOIMAGE%>");
	      		  $("#profpic2").attr("src", "<%=Constants.PATH_USERNOIMAGE%>");
	      		  $("#profpic3").attr("src", "<%=Constants.PATH_USERNOIMAGE%>");
	  	  	} else {
	  	  		  $("#profpic1").attr("src","data:image/;base64,<%=LoginData.getEmployeeData().getConvertedFilePic()%>");
	      		  $("#profpic2").attr("src","data:image/;base64,<%=LoginData.getEmployeeData().getConvertedFilePic()%>");
	      		  $("#profpic3").attr("src","data:image/;base64,<%=LoginData.getEmployeeData().getConvertedFilePic()%>");
	  	  	}
	   		
	   		//##1.Check Whether this a page redirecting or not
	   		var tmpIsRedirectPage = <%=request.getAttribute("needRedirect")%>;
	   		if(tmpIsRedirectPage != null){
	   			menuLoadHandler('<%=request.getAttribute("redirectPage")%>', '<%=request.getAttribute("redirectParam")%>');
	   		} else {
<%-- 				menuLoadHandler("<%=Constants.PAGES_LIST[Constants.Page.USER_PROJECT]%>"); --%>
	   		}
		});
	   	
	   	function refreshNotification(){
			alert("REFRESH");
	   		$.ajax({
		   	      type	  : "POST",
		   	      url	  : "Notification.do", //Hardcoded No Other Way :(  
		   	      data	  : "task=reloadNotification",
		   	      success : function(msg){
						$('#notif-wrapper').html(msg);
		   	      },
		   	      
		   	      error: function(){
		   	    	  alert("Something Wrong is Happening when Reload Notification !");
		   	      }
	   		})
	   	}
	</script>
<!-- End JS -->
</html>

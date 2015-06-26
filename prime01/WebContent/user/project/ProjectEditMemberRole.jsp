<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
	        //alert($('#roleId').val());
	        
	        var data = $('#roleId').val();
			var arr = data.split(', ');
	       // alert(arr.length);
	        for(i=0;i<arr.length;i++){
	        //	alert("Nomor = " + arr[i]);
	        	var temp = "#" + arr[i].toString();
	        //	alert(temp);
	        	$(temp).attr("checked", true);
	        	
	        }  
// 	       $("#1").attr("checked", true);
// 	        $("#4").attr("checked", true);
	    });
	</script>
	
	<!-- End JS -->
	
</head>
<body class="skin-blue sidebar-mini">
	
	<section class="content-header">
		<h1>Project<small>management project</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Project</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Edit Member Role</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser"  >
                		<html:hidden name="ProjectUserForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectName" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectAssigner" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectReceiver" />
                		<html:hidden name="ProjectUserForm" property="tempRoleId" styleId="roleId" />
                		<table class="form-input" align="center">
                			<tr>
                				
                				<td>
                				 	<!-- <html:select name="ProjectUserForm" property="projectBean.roleBean.roleId" styleId="roleid" styleClass="form-control">
		                  		  		<html:options collection="listAllRoles" property="roleId" labelProperty="roleName"/>
		                  		  	</html:select> -->
		                  		  	
		                  		  	<logic:notEmpty name="listAllRoles">
		                  		  		<logic:iterate id="iterate" name="listAllRoles">
		                  		  			<input type="checkbox" id='<bean:write name="iterate" property="roleId"/>'> <bean:write name="iterate" property="roleName"/><br>
		                  		  		</logic:iterate>
		                  		  	</logic:notEmpty>
		                  		  	
		                  		  	
                				</td>
                				
                			</tr>
                			<tr>
                				<td colspan="3" >
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="dosubmit()"/>
                					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                				</td>
                			</tr>
                			
                			
                		</table>
                	</html:form>
                  </div>
        	</div>
	</section>
	<!-- /.content-wrapper -->
		
	<!-- Modal -->
	<div class="modal fade" id="search-modal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Search Assigner</h4>
	      </div>
	      <div class="modal-body" id="search-modal-body">
	      
	      </div>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	<!--/. Modal  -->
		
		
	<script type="text/javascript">
		$(document).ready(function(){
			$('#btn-searchassigner').click(function(){
				//##0.Fetching Data
		        $.ajax({ 
	                type    : "POST",
	                url     : "ProjectUser.do",  // Send the login info to this page
	                data    : ("task=search-assigner"),
	                success : function(msg){
	               				$('#search-modal-body').html(msg);	 						
	                 		  }
		        });
			});
		});
		
		function helmyTest(id){
	        $.ajax({ 
                type   : "POST",
                url    : "ProjectUser.do",  // Send the login info to this page
                data   : ("task=search-assigner2"),
                success : function(msg){
               				$('#search-modal-body').html(msg);	 						
                 		  }
	        });
		}
	</script>
</body>
</html>
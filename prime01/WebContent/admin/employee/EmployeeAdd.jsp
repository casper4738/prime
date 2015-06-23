<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#datepicker_birthdate').datepicker({
                format: "yyyy-mm-dd"
            }); 
            $('#datepicker_hiredate').datepicker({
                format: "yyyy-mm-dd"
            });
    		$("#input-image").change(function (e) {
    		    if(this.disabled) 
    		    	return alert('File upload not supported!');
    		    var F = this.files;
    		    if(F && F[0]) {
    		    	for(var i=0; i<F.length; i++){
    		    		readImage( F[i] );
    		    	}
    		    }
    		});
    	});
		
		function readImage(file) {
		    var reader = new FileReader();
		    var image  = new Image();
		  
		    reader.readAsDataURL(file);  
		    reader.onload = function(_file) {
		        image.src    = _file.target.result;              // url.createObjectURL(file);
		        image.onload = function() {
		            var w = this.width;
		            var h = this.height;
		            var t = file.type;                           // ext only: // file.type.split('/')[1],
		            var n = file.name;
		            var s = file.size/1024;
		            	
	            	if(s <= <%=Constants.MAX_IMAGE_FILESIZE%>){
		            	$('#upload-preview').html('<img src="'+ this.src +'" style="width:64px;height:64px"> <br/><b>' + w +'x' +h+ ' <br/>'+s +'KB <br/>'+t+' <br>'+n+'<br/></b>');
	            	} else {
			            alert("File size too big !!");
			            
			            //Reset and Readd Event [Will think for better solution than double hardcode]
	            		$("#input-image").replaceWith($("#input-image").clone());
	            		$("#input-image").change(function (e) {
	            		    if(this.disabled) 
	            		    	return alert('File upload not supported!');
	            		    var F = this.files;
	            		    if(F && F[0]) {
	            		    	for(var i=0; i<F.length; i++){
	            		    		readImage( F[i] );
	            		    	}
	            		    }
	            		});
	            	}
		        };
		        image.onerror= function() {
            		$("#input-image").replaceWith($("#input-image").clone());
		            alert("Invalid file type ! Only input images files type");
		        };      
		    };
		    
		}
		
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=$('#positionId').val();
			var tmpTask ="modalTable";
			var tmpTable ="employeeHead";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition, $('#result'));
		}
    </script>
	<!-- End JS -->

</head>
<body class="skin-blue sidebar-mini">

	<section class="content-header">
		<h1>Manage Employee</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage Employee</li>
			<li class="active">Add Employee</li>
		</ol>
	</section>
	
	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box" align="center">
				<div class="box-header"><h1 class="box-title"><br/><br/><b>Add New Employee</b></h2><br/><br/></div>
					<div class="box-body">
			               	<html:form action="/EmployeeAdmin">
			               		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOADD%>"/>
			               		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId" />
			               		<html:hidden name="EmployeeAdminForm" property="employeeBean.managerId" />
			               		<html:hidden name="EmployeeAdminForm" property="managerId"/>
			               		<html:hidden name="EmployeeAdminForm" property="result" styleId="result"/>
			               		<table class="form-input" style="width: 500px;">
			             			<tr>
			               				<td width="200px">Name</td>
			               				<td>:</td>
			               				<td><html:text name="EmployeeAdminForm" property="employeeBean.employeeName" styleClass="form-control"/></td>
			               			</tr>
			               			<tr>
			               				<td>Address</td>
			               				<td>:</td>
			               				<td><html:text name="EmployeeAdminForm" property="employeeBean.address" styleClass="form-control"/></td>
			               			</tr>
			               			<tr>
			               				<td>Birth Date</td>
			               				<td>:</td>
			               				<td>
			               					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			               				  		<html:text name="EmployeeAdminForm" property="employeeBean.birthdate" styleClass="form-control pull-right" styleId="datepicker_birthdate"/>
			               				  	</div>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Contact Number</td>
			               				<td>:</td>
			               				<td>
			               					<html:text name="EmployeeAdminForm" property="employeeBean.contactNumber" styleClass="form-control"/>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Email</td>
			               				<td>:</td>
			               				<td>
			               					<html:text name="EmployeeAdminForm" property="employeeBean.email" styleClass="form-control"/>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Gender</td>
			               				<td>:</td>
			               				<td>              			
			               					<html:radio name="EmployeeAdminForm" property="employeeBean.gender" value="0" styleClass="minimal">Male</html:radio>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               					<html:radio name="EmployeeAdminForm" property="employeeBean.gender" value="1" styleClass="minimal">Female</html:radio>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Position</td>
			               				<td>:</td>
			               				<td>
				               				<html:select name="EmployeeAdminForm" property="employeeBean.positionId" styleClass="form-control" styleId="positionId">
				               					<html:options collection="listPosition" property="positionId" labelProperty="positionName" />
				               				</html:select>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Head</td>
			               				<td>:</td>
			               				<td class="input-group">
			               					<html:text name="EmployeeAdminForm" property="employeeBean.managerName" styleClass="form-control" styleId="headName" disabled="true"/>
			               					<span class="input-group-btn">
                      							<input type="button" class="btn btn-info" type="button" onclick="openModalHandler()" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
								            </span>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Division</td>
			               				<td>:</td>
				               			<td>
				               				<div id="isDivision" style="display: inline">
							               		<html:hidden name="EmployeeAdminForm" property="divisionId" />
				               					<html:text name="EmployeeAdminForm" property="employeeBean.divisionName" styleClass="form-control" disabled="true" styleId="divisionName"/>
											</div>
											<div id="chooseDivision" style="display:none">
				               					<html:select name="EmployeeAdminForm" property="employeeBean.divisionId" styleClass="form-control" styleId="divisionId">
					               					<html:options collection="listDivision" property="divisionId" labelProperty="divisionName" />
					               				</html:select>
											</div>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Hire Date</td>
			               				<td>:</td>
			               				<td>
			               					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			               				  		<html:text name="EmployeeAdminForm" property="employeeBean.hireDate" styleClass="form-control pull-right" styleId="datepicker_hiredate"/>
			               				  	</div>
										</td>
			               			</tr>
			               			<tr>
			               				<td>Profile Picture [Max. <%=Constants.MAX_IMAGE_FILESIZE %> KB]</td>
			               				<td>:</td>
			               				<td>
			               				  <input type="file" id="input-image" accept="image/*">
										</td>
			               			</tr>
			               			<tr>
			               				<td></td>
			               				<td></td>
			               				<td>
										  <div id="upload-preview"></div>
			               				</td>
			               			</tr>
			               			<tr>
			               				<td colspan="3" align="center">
			               					<input type="button" value="Save" class="btn btn-primary"  onclick="dosubmit()"/> 
			               					<input type="button" value="Cancel" class="btn btn-default" onclick="flyToPage('<%=Constants.Task.BACKTOMAIN%>')"/>					
			               				</td>
			               			</tr>
							 </table>
			                 </html:form>
			        </div>
		       	</div>
	       	</div>
	       </div>
	</section>
</body>
</html>
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
					var pathFile = document.getElementById("input-image").value;
					//document.forms[0].path.value = pathFile;
					var tmppath = URL.createObjectURL(event.target.files[0]);
					document.forms[0].path.value = tmppath;
    		    	for(var i=0; i<F.length; i++){
    		    		readImage( F[i] );
    		    	}
    		    }
				alert("file:"+serialize(document.getElementById("tes")  ) );
    		});
    	});
		
		function readImage(file) {
		    var reader = new FileReader();
		    var image  = new Image();
		    
		    var reader2 = new FileReader();
		    reader2.readAsArrayBuffer(file);
		    alert("test = " + reader2);
		    
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
	            		
		            	$('#upload-preview').html('<img src="'+ this.src +'" style="width:64px;height:64px"> <br/><b>' + w +'x' +h+ ' <br/>'+s +'KB <br/>'+t+' <br>'+n+'<br/>	</b>');
		            	
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
		var imgFile = document.getElementById('submitfile');
		if (imgFile.files && imgFile.files[0]) {
		    var width;
		    var height;
		    var fileSize;
		    var reader = new FileReader();
		    reader.onload = function(event) {
		        var dataUri = event.target.result,
		        img = document.createElement("img");
		        img.src = dataUri;
		        width = img.width;
		        height = img.height;
		        fileSize = imgFile.files[0].size;
		        alert(width);
		        alert(height);
		        alert(fileSize);
		   };
		   reader.onerror = function(event) {
		       console.error("File could not be read! Code " + event.target.error.code);
		   };
		   reader.readAsDataURL(imgFile.files[0]);
		}
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=$('#positionId').val();
			var tmpTask ="modalTable";
			var tmpTable ="employeeHead";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=employeeAdd", $('#result'));
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
			               	<html:form action="/EmployeeAdmin" enctype="multipart/form-data" styleId="tes">
			               		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOADD%>"/>
			               		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId" />
			               		<html:hidden name="EmployeeAdminForm" property="employeeBean.managerId" />
			               		<html:hidden name="EmployeeAdminForm" property="managerId"/>
			               		<html:hidden name="EmployeeAdminForm" property="path"/>
			               		<html:hidden name="EmployeeAdminForm" property="result" styleId="result"/>
			               		<table class="form-input" style="width: 500px;">
			               			<tr>
			               				<td>Profile Picture [Max. <%=Constants.MAX_IMAGE_FILESIZE %> KB]</td>
			               				<td>:</td>
			               				<td>
			               				  <html:file styleId="input-image" accept="image/*" name="EmployeeAdminForm" property="employeeBean.filePic"/>
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
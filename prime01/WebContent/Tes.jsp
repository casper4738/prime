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
            
//             <img alt="Embedded Image" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIA..." />
            
			var pathFile = document.getElementById("input-image").value;
			//document.forms[0].path.value = pathFile;
			var tmppath = URL.createObjectURL(event.target.files[0]);
			document.forms[0].path.value = tmppath;
            
            return;
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
    		});
    	});
		
		function readImage(file) {
		    var reader = new FileReader();
		    var image  = new Image();
		    alert("?????");
		    $.ajax({
		        url: '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>',
		        type: "POST",
		        data: {task : "asd", profpic : file},
		        processData: false
		    });
		    return
		    var reader2 = new FileReader();
		    reader2.onprogress  = function(evt){
			    alert(evt.lengthComputable);
		        // evt is an ProgressEvent.
		        if (evt.lengthComputable) {
		        	//alert(Math.round((evt.loaded / evt.total) * 100));
		          var percentLoaded = Math.round((evt.loaded / evt.total) * 100);
		          // Increase the progress bar length.
		          if (percentLoaded <= 100) {
		        	  //alert("Trast" + percentLoaded);
		        	  //$('#progress-barsing').attr("width", (percentLoaded.toString() + '%'));
		          }
		        }
		    };
		    reader2.onloadend = function(evt) {
		        if (evt.target.readyState == FileReader.DONE) { // DONE == 2
		        	alert(evt.target.result);
		        	var arrBuff = new ArrayBuffer(evt.target.result.length);
		        	var writer = new Uint8Array(arrBuff);
		        	for (var i = 0, len = evt.target.result.length; i < len; i++) {
		        	    writer[i] = evt.target.result.charCodeAt(i);
		        	}
// 		          	$.ajax({
<%-- 		        	    url			: '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>', --%>
// 		        	    dataType	: 'json',
// 		        	    type		: 'POST',
// 		        	    processData : false,
// 		        	    data		: {task : "asd", profpic : writer}, //your string data
// 		        	    success		: function (response) {
// 		        	        alert("hi");
// 		        	    }
// 		        	}); 
 		        }
		    };
		    reader2.readAsBinaryString(file);
		    
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
			               		<html:hidden name="EmployeeAdminForm" property="task" value="bytearray"/>
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
			               				  <html:file styleId="input-image" accept="image/*" name="EmployeeAdminForm" property="profpic"/>
										</td>
			               			</tr>
			               			<tr>
			               				<td colspan="3">
							                  <div class="progress">
							                    <div class="progress-bar progress-bar-green" role="progressbar" id="progress-barsing" style="width:0%">
							                    </div>
							                  </div>
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
			               					<input type="submit" value="Save" class="btn btn-primary" /> 
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
<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Prime</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	<script>
		function chooseReceiver(managerId) {
			var tmpForm = document.forms[0];
			tmpForm.taskReceiver.value = managerId;
			tmpForm.task.value= "<%=Constants.Task.GOTOADD%>";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function onclickradio() {
			var checked = document.getElementById("head").checked;
			if(checked) {
				document.getElementById("table_data").style.display= "none";				
				document.getElementById("myBtn").style.display= "block";				
			} else {
				document.getElementById("table_data").style.display= "block";				
				document.getElementById("myBtn").style.display= "none";				
			}
		}
		

		function onSelectManager(value) {
			var tmpForm = document.forms[0];
			tmpForm.task.value= "<%=Constants.Task.GOTOMANAGER%>";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
		    language  : { 
		    	"emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>" 
		    }
	    });
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks<small> As Head</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')">Tasks & Activities</html:link></li>
			<li class="active">Choose Type</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Task Type</h3></div>
			<div class="box-body">
           		<table align="center">
           			<tr>
           				<td height="45px"><html:radio name="TaskHeadUserForm" property="radioChoose" styleId="head" value="0" onclick="onclickradio()" /></td>
           				<td width="150px"><label for="head">Self Assign</label></td>
           				<td><input type="button" value="Next" style="display:none" class="btn bg-olive" id="myBtn" onclick="chooseReceiver('${employeeIdActive}')"/></td>
       				</tr>
           			<tr><td width="25px"><html:radio name="TaskHeadUserForm" property="radioChoose" styleId="subordinate" value="1" onclick="onclickradio()" /></td>
           				<td><label for="subordinate">Subordinate</label></td> 	
           				<td></td>
       				</tr>
       			</table>
            	
            	<br/><br/><br/>
              	<div id="table_data">
              	
              	<!-- Search Handler Tag -->
              	<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="TaskHeadUserForm" styleId="view_data">
						<html:optionsCollection name="listShowEntries" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
					<html:form action="/TaskHeadUser">
	               		<html:hidden name="TaskHeadUserForm" property="task" />
	               		<html:hidden name="TaskHeadUserForm" property="showInPage" />
	               		<html:hidden name="TaskHeadUserForm" property="taskReceiver" />
						<html:hidden name="TaskHeadUserForm" property="goToPage"/>
						<html:hidden name="TaskHeadUserForm" property="showInPage"/>
						<html:select name="TaskHeadUserForm" property="columnSearch" styleClass="columnSearch">
							<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						</html:select>
						<html:text name="TaskHeadUserForm" property="search" styleClass="textSearch"/>
						<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="TaskHeadUserForm" property="task" />', 'false')" value='Search'/>
						<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="TaskHeadUserForm" property="task" />', 'true')" value='Show All'/>					
					</html:form>
				</div>
					<div class="box-body">
					<table class="table table-bordered table-striped table-hover" >
						<thead>
							<tr>
								<th>Employee ID</th>
								<th>Name</th>
								<th align="center">Gender</th>
								<th>Address</th>
								<th>Email</th>
								<th align="center">Division</th>
								<th align="center">Position</th>
								<th>Manager</th>
			                    <th width="90px">Actions</th>
			                </tr>
			            </thead>
		                <tbody>
		                <logic:notEmpty name="listEmployee">
							<logic:iterate id="iter" name="listEmployee">
			                	<tr>
			                		<td align="center"><bean:write name="iter" property="employeeId"/> </td>
			                		<td><bean:write name="iter" property="employeeName"/> </td>
			                		<td><logic:equal name="iter" property="gender" value="0">
				                			Male
				                		</logic:equal>
				                		<logic:equal name="iter" property="gender" value="1">
				                			Female
				                		</logic:equal>
			                		</td>
			                		<td><bean:write name="iter" property="address"/> </td>
			                		<td><bean:write name="iter" property="email"/> </td>
			                		<td><bean:write name="iter" property="divisionName"/> </td>
			                		<td><bean:write name="iter" property="positionName"/> </td>
			                		<td><bean:write name="iter" property="managerName"/> </td>
			                        <td align="center">
			                        	<input type="button" value="select" class="btn bg-olive" onclick="chooseReceiver('<bean:write name="iter" property="employeeId"/>') "/>
			                        </td>
			                    </tr>
		                    </logic:iterate>
							</logic:notEmpty>
	                   </tbody>
		            </table>
		            </div>
					<!-- Paging -->
		            <jsp:include page="/content/Pagination.jsp">
		    			<jsp:param name="formName" value="TaskHeadUserForm" />
		    		</jsp:include>
					<!-- End of Paging -->
					</div>
                  </div>
        	</div></div>
        </div>
	</section>

</body>
</html>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
		    language  : { 
		    	"emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>" 
		    }
	    });
		
		function flyToTaskDetail(task, value) {
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.projectId.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
	
		/* function dari indra */
		/* $(document).ready(function () {
			$('.btnCancel').on('click',function (){
				var task= $('#hdTask').val();
			     var assignTo = $(this).closest('tr').find('.assTo').val(); 
				 alert(task);
			});
			
	    }); */
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Project User</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li class="active">Manage Project</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Projects</h3></div>
			
			<p><span class="button-add btn btn-app bg-olive btnCancel" onclick="javascript:flyToPage('<%=Constants.Task.GOTOADD%>')">
                   <i class="fa fa-edit"></i>Add
                  </span>
                  <p><span class="message"><bean:write name="ProjectUserForm" property="message" /></span></p>
			<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="ProjectUserForm">
						<html:optionsCollection name="listShowEntries" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
					<html:form action="<%=Constants.PAGES_LIST[Constants.Page.USER_PROJECT]%>" method="post">
						<html:hidden property="task" styleId="hdTask"/>
						<html:hidden name="ProjectUserForm" property="projectId"/>
						<html:select name="ProjectUserForm" property="columnSearch">
							<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						</html:select>
						<html:text name="ProjectUserForm" property="search"/>
						<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('search')" value='Search'/>
						<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('search')" value='Show All'/>
					</html:form>
				</div>
			<!-- End Of Search Handler -->
			<div class="box-body"><table id="table-1" class="table table-bordered table-striped table-hover">
				<thead><tr>
					<th width="100px">Project Name</th>
					<th width="100px">Description</th>
					<th width="100px">Project Assigner</th>
					<th width="100px">Start Date</th>
					<th width="100px">Estimate Date</th>	
					<th width="100px">Status</th>				
                    <th width="100px">Actions</th>
                </tr></thead>
                <tbody>
                <logic:notEmpty name="listProject">
					<logic:iterate id="iter" name="listProject">
	                	<tr>
	                	    <td>
	                	    	<html:hidden property="projectName" name="iter" styleClass="assTo"/>
	                	    <bean:write name="iter" property="projectName"/></td>
	                	    <td><bean:write name="iter" property="projectDescription"/></td>
	                	    <td><bean:write name="iter" property="projectAssigner"/></td>
	                	    <td><bean:write name="iter" property="projectStartDate" format="dd MMMM yyyy"/></td>
	                	    <td><bean:write name="iter" property="projectEstimateDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center">
		                	    <jsp:include page="/content/Status.jsp">
                	    			<jsp:param name="status" value="${iter.projectLastStatus}" />
                	    		</jsp:include>
              	    			</td>
	                        <td align="center">
	                        	<input type="submit" class="btn btn-primary btn-xs" value='Details' 
		                        	onclick="flyToTaskDetail('<%=Constants.Task.PROJECT.GOTOPROJECTDETAIL %>', '<bean:write name="iter" property="projectId"/>')" >
	                        </td>
	                    </tr>
                    </logic:iterate>
					</logic:notEmpty>
                  </tbody>
            </table></div>
			<ul class="pagination">
				<li tabindex="0"><html:link styleClass="paging" href="#" onclick="page(${pageFirst})">First</html:link></li>
				<li tabindex="1"><html:link styleClass="paging" href="#" onclick="page(${pagePrev})"><<</html:link> </li>
				
				<logic:iterate id="p" name="listPage">
					<logic:equal name="p" value="${pageNow}">
						<li><html:link styleClass="active" href="#">${p}</html:link> </li>
					</logic:equal>
					<logic:notEqual name="p" value="${pageNow}">
						<li><html:link styleClass="paging" href="#" onclick="page(${p})">${p}</html:link> </li>
					</logic:notEqual>
				</logic:iterate>
				<li><html:link styleClass="paging" href="#" onclick="page(${pageNext})" >>></html:link> </li>
				<li><html:link styleClass="paging" href="#" onclick="page(${pageLast})" >Last</html:link></li>
				
				<div class="paginate-3">
					<html:text name="ProjectUserForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
					<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
				</div>
			</ul>
			
			<div class="paginate-2">
				Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
			</div>
        </div>
		</div></div>
	</section>
</body>
</html>
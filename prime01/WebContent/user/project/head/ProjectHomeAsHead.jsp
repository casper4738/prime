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
		
		function flyToTaskDetailAsHead(task, value, valueId) {
			
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.projectId.value = value;
			tmpForm.employeeIdReceiver=valueId;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		$(document).ready(function () {
            $('#start').datepicker({
                format: "yyyy-mm-dd"
            });  
            $('#until').datepicker({
                format: "yyyy-mm-dd"
            });  
            
            $('.columnSearch').on('change',function(){
            	onselect($(this).val());
            });
            
            onselect($('.columnSearch').val());
        });
		
		function onselect(value) {
			if(value == "STARTDATE" || value == "ESTIMATEDATE") {
            	$('#textSearch').css('display', 'none') ;
            	$('#date_start').css('display', 'block') ;
            	$('#date_line').css('display', 'block') ;
            	$('#date_until').css('display', 'block') ;
            } else {
            	$('#textSearch').css('display', 'block') ;
            	$('#date_start').css('display', 'none') ;
            	$('#date_line').css('display', 'none') ;
            	$('#date_until').css('display', 'none') ;
            }
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
			<div class="box-header"><h3 class="box-title">Projects Head</h3></div>
			
			<logic:notEqual name="ProjectUserFormAsHead" property="countUnderLevel" value="0">
				<p><span class="button-add btn btn-app bg-olive btnCancel" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
	               <i class="fa fa-edit"></i>Add
           		</span>
			</logic:notEqual>
			
           	<p><span class="message"><bean:write name="ProjectUserFormAsHead" property="message" /></span></p>
            
			<!-- Search Handler Tag -->
			<div class="show-in-page">
				Show per page
				<html:select property="showInPage" name="ProjectUserFormAsHead" onchange="change(this.value)">
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select> 
			</div>
			<div class="search-table">
				<html:form action="/ProjectUserAsHead" method="post">
					<html:hidden property="task" styleId="hdTask"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectId"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectLastStatus"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectReceiver"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.employeeIdReceiver"/>
					<html:hidden name="ProjectUserFormAsHead" property="goToPage"/>
					<html:hidden name="ProjectUserFormAsHead" property="showInPage"/>
					<html:hidden name="ProjectUserFormAsHead" property="isShowAll"/>
					<table>
						<tr>
							<td style="padding-left:5px"><html:select name="ProjectUserFormAsHead" property="columnSearch" styleClass="form-control columnSearch">
									<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
								</html:select>
							</td>
							<td style="padding-left:5px"><html:text name="ProjectUserFormAsHead" property="search" styleClass="form-control textSearch" styleId="textSearch"/></td>
							<td style="padding-left:5px">
								<div id="date_start">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
      				  					<html:text name="ProjectUserFormAsHead" property="startDate" styleClass="form-control pull-right" styleId="start"/>
      				  				</div>
      				  				</div>
      				  			</td>
							<td style="padding-left:5px"><div id="date_line">-</div></td>
							<td style="padding-left:5px">
								<div id="date_until">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
      				  					<html:text name="ProjectUserFormAsHead" property="untilDate" styleClass="form-control pull-right" styleId="until" />
      				  				</div>
      				  				</div>
      				  			</td>
							<td style="padding-left:5px">
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ProjectUserFormAsHead" property="task" />', 'false')" value='Search'/>
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ProjectUserFormAsHead" property="task" />', 'true')" value='Show All'/>					
							</td>
						</tr>
					</table>
				</html:form>
			</div>
			<!-- End Of Search Handler -->
			
			<!-- Table List -->
			<div class="box-body"><table id="table-1" class="table table-bordered table-striped table-hover">
				<thead><tr>
					<th width="100px">Project Name</th>
					<th>Description</th>
					<th width="100px">Project Manager</th>
					<th width="100px">Assigned By</th>
					<th width="65px">Start Date</th>
					<th width="65px">Estimate Date</th>	
					<th width="30px">Status</th>				
                    <th width="100px">Actions</th>
                </tr></thead>
                <tbody>
                <logic:notEmpty name="listProject">
					<logic:iterate id="iter" name="listProject">
						
	                	<tr>
	                	    <td><bean:write name="iter" property="projectName"/></td>
	                	    <td><bean:write name="iter" property="projectDescription"/></td>
	                	    <td><bean:write name="iter" property="projectReceiverName"/></td>
	                	    <td><bean:write name="iter" property="projectAssignerName"/></td>
	                	    <td align="center"><bean:write name="iter" property="projectStartDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center"><bean:write name="iter" property="projectEstimateDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center">
		                	    <jsp:include page="/content/Status.jsp">
                	    			<jsp:param name="status" value="${iter.projectLastStatus}" />
                	    		</jsp:include>
           	    			</td>
	                        <td width="150px" align="center">
		                        <input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToTaskDetailAsHead('detailsAsHead', '<bean:write name="iter" property="projectId"/>',  '<bean:write name="iter" property="employeeIdReceiver"/>')" >	
	                        </td>
	                    </tr>
                    </logic:iterate>
					</logic:notEmpty>
                  </tbody>
            </table></div>
            <!-- End Of Table List -->
		            
			<!-- Paging -->
            <jsp:include page="/content/Pagination.jsp">
    			<jsp:param name="formName" value="ProjectUserFormAsHead" />
    		</jsp:include>
			<!-- End of Paging -->
        </div>
		</div></div>
	</section>
</body>
</html>
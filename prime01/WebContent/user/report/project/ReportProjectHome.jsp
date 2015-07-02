<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
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
	    } );
		
		
		function flyToProjectTaskDetail(task, value) {
			var tmpForm = document.forms[0];
			tmpForm.task.value = task;
			tmpForm.projectId.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		 function generateReport(){
				document.forms[0].target = "_blank";
				document.forms[0].task.value = "<%=Constants.Task.REPORT.GENERATEREPORTPROJECT%>";
				document.forms[0].submit();
			 }
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Project Report</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li class="active">Project Report</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Project Report Data</h3></div>
	            <p><span class="button-add btn btn-app bg-olive btnCancel" onclick="generateReport()">
	               <i class="fa fa-save"></i>Export
	              </span>
	              </p>
            <p><span class="message"><bean:write name="ReportUserProjectForm" property="message" /></span></p>    
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="ReportUserProjectForm" onchange="change(this.value)">
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
				<html:form action="/ReportProject">
					<html:hidden name="ReportUserProjectForm" property="task"/>
					<html:hidden name="ReportUserProjectForm" property="tmpId"/>
					<html:hidden name="ReportUserProjectForm" property="goToPage"/>
					<html:hidden name="ReportUserProjectForm" property="showInPage"/>
					<html:hidden name="ReportUserProjectForm" property="projectId"/>
<<<<<<< HEAD
					<html:hidden name="ReportUserProjectForm" property="isShowAll"/>
				<table>
					<tr>
					<td style="padding-left:5px">				
					<html:select name="ReportUserProjectForm" property="columnSearch" styleClass="form-control columnSearch">
=======
				
					<html:select name="ReportUserProjectForm" property="columnSearch">
>>>>>>> branch 'master' of https://github.com/casper4738/prime.git
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
<<<<<<< HEAD
					</td>
					<td style="padding-left:5px"><html:text name="ReportUserProjectForm" property="search" styleClass="form-control textSearch" styleId="textSearch"/></td>
					<td style="padding-left:5px">
								<div id="date_start">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
	     				  					<html:text name="ReportUserProjectForm" property="startDate" styleClass="form-control pull-right" styleId="start"/>
	     				  		</div>
	     				  		</div>
	     			</td>
							<td style="padding-left:5px"><div id="date_line">-</div></td>
							<td style="padding-left:5px">
								<div id="date_until">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
	     				  					<html:text name="ReportUserProjectForm" property="untilDate" styleClass="form-control pull-right" styleId="until" />
	     				  		</div>
	     				  		</div>
   				  			</td>
   				  			<td style="padding-left:5px">
								<input type="button" class="btn bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ReportUserProjectForm" property="task" />', 'false')" value='Search'/>
								<input type="button" class="btn bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ReportUserProjectForm" property="task" />', 'true')" value='Show All'/>
   				  			</td>
   				  	</tr>
   				 </table>
=======
					<html:text name="ReportUserProjectForm" property="search"/>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Search'/>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="searchAll('<%=Constants.Task.DOSEARCH%>')" value='Show All'/>
>>>>>>> branch 'master' of https://github.com/casper4738/prime.git
				</html:form>
				</div>
				<!-- End Of Search Handler -->
		
				<!-- Table List -->
				<div class="box-body">
					<table id="table-1" class="table table-bordered table-striped table-hover">
						<thead>
							<tr>
								<th width="100px">Project Name</th>
								<th>Description</th>
								<th width="100px">Project Manager</th>
								<th width="100px">Proposed By</th>
								<th width="65px">Start Date</th>
								<th width="65px">Estimate Date</th>	
								<th width="30px">Status</th>				
			                    <th width="100px">Actions</th>
			                </tr>
			            </thead>
			              <tbody>
			               <logic:notEmpty name="listReportProject">
							<logic:iterate id="iter" name="listReportProject">
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
			                        	<input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToProjectTaskDetail('<%=Constants.Task.REPORT.GOTODETAILPROJECT %>', '<bean:write name="iter" property="projectId"/>')">
			                        </td>
			                    </tr>
		                    </logic:iterate>
							</logic:notEmpty>
		                   </tbody>
			            </table>
			            </div>
			            <!-- End Of Table List -->
			            
			            <!-- Paging -->
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
							
							<html:text name="ReportUserProjectForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
							<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
						</ul>
						<div class="paginate-2">
							Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
						</div>
						<!-- End of Paging -->
		        	</div>
	        	</div>
	      </div>
	</section>
</body>
</html>

<%@page import="prime.constants.Constants"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End of CSS -->
	
	<!-- JS -->
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
<<<<<<< HEAD
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
=======
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
>>>>>>> branch 'master' of https://github.com/casper4738/prime.git
	<script type="text/javascript">
		$('#table-1').dataTable( {
		   paging    : false,
		   searching : false,
		   info   	 : false,
		   language  : { "emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>"}
		});
		
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
			if(value == "DATE") {
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
		
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Holiday<small>management system</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
			<li class="active">Manage Holiday</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Holiday</h3></div>
				
				<p><span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
                   		<i class="fa fa-edit"></i>Add
                   </span>
	            <span class="message"><bean:write name="HolidayAdminForm" property="message" /></span></p>
	                  
	            <!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select name="HolidayAdminForm" property="showInPage" onchange="change(this.value)" >
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
					<html:form action="/HolidayAdmin" >
						<html:hidden name="HolidayAdminForm" property="task"/>
						<html:hidden name="HolidayAdminForm" property="tmpId"/>
						<html:hidden name="HolidayAdminForm" property="goToPage"/>
						<html:hidden name="HolidayAdminForm" property="showInPage"/>
						<table>
							<tr>
								<td style="padding-left:5px"><html:select name="HolidayAdminForm" property="columnSearch" styleClass="form-control columnSearch">
										<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
									</html:select>
								</td>
								<td style="padding-left:5px"><html:text name="HolidayAdminForm" property="search" styleClass="form-control textSearch" styleId="textSearch"/></td>
								<td style="padding-left:5px">
									<div id="date_start">
									<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
       				  					<html:text name="HolidayAdminForm" property="startHoliday" styleClass="form-control pull-right" styleId="start"/>
       				  				</div>
       				  				</div>
       				  			</td>
								<td style="padding-left:5px"><div id="date_line">-</div></td>
								<td style="padding-left:5px">
									<div id="date_until">
									<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
       				  					<html:text name="HolidayAdminForm" property="untilHoliday" styleClass="form-control pull-right" styleId="until" />
       				  				</div>
       				  				</div>
       				  			</td>
								<td style="padding-left:5px">
									<input type="button" class="btn bg-olive" style="height:32px" onclick="flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Search'/>
									<input type="button" class="btn bg-olive" style="height:32px" onclick="searchAll('<%=Constants.Task.DOSEARCH%>')" value='Show All'/>
								</td>
							</tr>
						</table>
					</html:form>
				</div>
				<!-- End Of Search Handler -->
				
				<!-- Table List -->
				<div class="box-body"><table id="table-1" class="table table-bordered table-striped table-hover">
					<thead><tr>
						<th width="150px">Date</th>
						<th>Holiday Description</th>
	                    <th width="90px">Actions</th>
	                </tr></thead>
	                <tbody>
	                <logic:notEmpty name="listHoliday">
						<logic:iterate id="iter" name="listHoliday">
		                	<tr><td align="center"><bean:write name="iter" property="holidayDate" format="dd MMMM yyyy"/></td>
		                	    <td><bean:write name="iter" property="holidayDescription"/></td>
		                        <td align="center">
		                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="holidayDate"/>')" src="resources/image/edit.png"/>
		                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.DODELETE%>', '<bean:write name="iter" property="holidayDate"/>', '<%=Constants.Confirmation.DELETE %>')" src="resources/image/remove.png" />
		                        </td>
		                    </tr>
	                    </logic:iterate>
					</logic:notEmpty>
					</tbody>
	            </table></div>
	           	<!-- End Of Table List -->
	              
				<!-- Paging -->
		        <jsp:include page="/content/Pagination.jsp">
		   			<jsp:param name="formName" value="HolidayAdminForm" />
		   		</jsp:include>
				<!-- End of Paging -->
	        </div></div>
        </div>
	</section>
</body>
</html>

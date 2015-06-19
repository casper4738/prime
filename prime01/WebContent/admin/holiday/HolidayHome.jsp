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
	<meta charset="UTF-8">
	<title>Prime</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<jsp:include page="/content/Header.jsp"></jsp:include>
		
		<div class="content-wrapper">
			<section class="content-header">
				<h1>Manage Holiday<small>management system</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
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
					<div class="show-in-page">
						Show per page
						<html:select name="HolidayAdminForm" property="showInPage" onchange="change(this.value)" >
							<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
						</html:select>
					</div>
					<div class="search-table">
						<html:form action="/HolidayAdmin" >
							<html:hidden name="HolidayAdminForm" property="task" value="search"/>
							<html:hidden name="HolidayAdminForm" property="tmpId"/>
							<html:hidden name="HolidayAdminForm" property="goToPage"/>
							<html:hidden name="HolidayAdminForm" property="showInPage"/>
							<html:select name="HolidayAdminForm" property="columnSearch" styleClass="columnSearch">
								<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
							</html:select>
							<html:text name="HolidayAdminForm" property="search" styleClass="textSearch"/>
							<input type="submit" onclick="javascript:flyToPage('search')" class="buttonSearch myButton" value='Search'>
						</html:form>
					</div>
					<div class="box-body"><table 
					
					class="table table-bordered table-striped table-hover">
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
			                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.DODELETE%>', '<bean:write name="iter" property="holidayDate"/>')" src="resources/image/remove.png" />
			                        </td>
			                    </tr>
		                    </logic:iterate>
							</logic:notEmpty>
							<logic:empty name="listHoliday">
								<tr>
									<td align="center" colspan="3"><bean:message key="label.table.notfound" /></td>
								</tr>
							</logic:empty>
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
							<html:text name="HolidayAdminForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
							<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
						</div>
					</ul>
					
					<div class="paginate-2">
						Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
					</div>
		        </div></div>
		        
		        </div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="/content/Footer.jsp"></jsp:include>
	</div>

	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>
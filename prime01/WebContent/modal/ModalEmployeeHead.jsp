<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<!-- <script src="resources/prime.js"></script> -->
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
	 		scrollY	  : "300px",
			language  : {
		       "emptyTable":  "<center><%=Constants.Response.TABLE_HEAD_EMPTY %></center>"
		    }
	    } );
		
		//Method Specified For Modal Handling
		function modalFlyToPage(isBool) {
			var tmpForm = document.getElementById("idForm");
			tmpForm.isShowAll.value = isBool;
			modalLoadHandler(serialize(tmpForm));
		}
		
		function modalPage(page) {
			var tmpForm = document.getElementById("idForm");
			if(page == -1) {
				tmpForm.goToPage.value = document.getElementById('page').value;
			} else {
				tmpForm.goToPage.value = page;			
			}
			modalLoadHandler(serialize(tmpForm));
		}
		
		function modalChange(value) {
			var tmpForm = document.getElementById("idForm");
			tmpForm.showInPage.value = value;
			modalLoadHandler(serialize(tmpForm));
		}
		
		function modalSelectHandler(retValue,retForm){
			modalSubmitReturnValue(retValue,retForm);
		}
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h1 class="box-title"><b>${modalListName}</b></h1><br/><br/></div>
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="ModalForm" onchange="modalChange(this.value)">
						<html:optionsCollection name="listShowEntries" label="value" value="key"/>
					</html:select>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="modalFlyToPage('<%=Constants.Task.DOSEARCH%>')" value='Refresh'/>
				</div>
				<html:form action="/Modal" styleId="idForm">
				<div class="search-table">
					<html:hidden name="ModalForm" property="task"/> 
				    <html:hidden name="ModalForm" property="param1"/>
				    <html:hidden name="ModalForm" property="param2"/>
				    <html:hidden name="ModalForm" property="param3"/>
				    <html:hidden name="ModalForm" property="param4"/>
				    <html:hidden name="ModalForm" property="param5"/>
				    <html:hidden name="ModalForm" property="isShowAll"/>
				    <html:hidden name="ModalForm" property="showInPage"/>
					<html:select name="ModalForm" property="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="ModalForm" property="search"/>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="modalFlyToPage('false')" value='Search'/>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="modalFlyToPage('true')" value='Show All'/>
				</div>
				<!-- End Of Search Handler -->
		
				<!-- Table List -->
				<div class="box-body">
					<table id="table-1" class="table table-bordered table-striped table-hover">
						<thead>
							<tr>
								<logic:iterate id="columnName" name="listColumnHead">
									<th>${columnName}</th>
								</logic:iterate>
			                    <th width="90px">Actions</th>
			                </tr>
			            </thead>
			            <tbody>
		               	   <!-- If Data Exists -->
			               <logic:notEmpty name="listTableData">
								<logic:iterate id="rowData" name="listTableData" indexId="dataIdx">
				                	<tr>
										<logic:iterate id="obj" name="rowData">
				                			<td>${obj}</td>
				                		</logic:iterate>
					                    <td align="center">
											<input type="button" class="btn bg-olive" style="height:32px" onclick="modalSelectHandler('${rowData}','${modalForm}')" value='Select'/>
					                    </td>
						             </tr>
					             </logic:iterate>
							</logic:notEmpty>
		               </tbody>
				   </table>
			    </div>
			    <!-- End Of Table List -->
			            
	            <!-- Paging Number Handler Tag -->
				<ul class="pagination">
					<li tabindex="0"><html:link styleClass="paging" href="javascript: void(0)" onclick="modalPage(${pageFirst})">First</html:link></li>
					<li tabindex="1"><html:link styleClass="paging" href="javascript: void(0)" onclick="modalPage(${pagePrev})"><<</html:link> </li>
					
					<logic:iterate id="p" name="listPage">
						<logic:equal name="p" value="${pageNow}">
							<li><html:link styleClass="active" href="javascript: void(0)">${p}</html:link> </li>
						</logic:equal>
						<logic:notEqual name="p" value="${pageNow}">
							<li><html:link styleClass="paging" href="javascript: void(0)" onclick="modalPage(${p})">${p}</html:link> </li>
						</logic:notEqual>
					</logic:iterate>
					<li><html:link styleClass="paging" href="javascript: void(0)" onclick="modalPage(${pageNext})" >>></html:link> </li>
					<li><html:link styleClass="paging" href="javascript: void(0)" onclick="modalPage(${pageLast})" >Last</html:link></li>
					
					<html:text name="ModalForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
					<html:button property="" onclick="modalPage(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
				</ul>
				<div class="paginate-2">
					Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
				</div>
				<!-- End Of Paging Number Handler Tag -->
				</html:form>
        	</div>
       	</div>
	    </div>
	</section>
</body>
</html>

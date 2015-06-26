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
    <link href="resources/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/fullcalendar/fullcalendar.print.css" rel="stylesheet" type="text/css" media='print' />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/extensions/FixedColumns/css/dataTables.fixedColumns.min.css" rel="stylesheet" type="text/css" />
	<!-- End of CSS -->
	
	<!-- JS -->
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/plugins/jQueryUI/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
    <script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='resources/plugins/fastclick/fastclick.min.js'></script>
    <script src="resources/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/extensions/FixedColumns/js/dataTables.fixedColumns.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function(){
           //Prepare Calendar
		   $('#datepicker_activitydate').datepicker({
               format	: "yyyy-mm-dd"
           });
	  		  
  		   //Load Activity Progress Timetable
  		   loadActivityProgress();
		});
    	
		//##.Activity Detail
    	function activityDetail(task,activityId,status){
    		document.forms[0].task.value = task;
    		document.forms[0].tmpId.value = activityId;
    		document.forms[0].tmpValue.value = status;
    		document.forms[0].submit();
    	}
		
		//##.Activity Progress
		function loadActivityProgress(isToday){
			//Set Current Date
		  	var tmpDate = new Date();
	        var tmpMonthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
			alert(tmpDate);
	        var d = tmpDate.getDate();
			var m = tmpDate.getMonth() + 1;
			var y = tmpDate.getFullYear();
			var tmpRefreshDate = d + "/" + m + "/" + y;
			$('#datepicker_activitydate').datepicker('setDate', tmpDate);
			alert("2");
			$('#date_activitydate').html("<b>" + ((d < 10) ? ("0" + d) : d) + " " + tmpMonthList[m - 1] + " " + y + "</b>");    
			
			alert("WAT");
			
	  		//Do Login Data checking
	  		$.ajax({ 
	  	    	type 	: "POST",
	  	    	url	  	: "<%=Constants.PAGES_LIST[Constants.Page.USER_DASHBOARD]%>",  
	  	    	data	: "task=refreshActivityProgress&loadDate=" + tmpRefreshDate,
	  	    	success : function(msg){
	  	    		var table;
			  		$('#table-1').html(msg);
			 		table = $('#table-1').dataTable( {
			 			ordering 		: false,
			 			paging    		: false,
			 			searching 		: false,
			 			info	  		: false,
			 			scrollY	  		: "250px",
			 		    scrollX	  		: "100%",
			 		    scrollCollapse	: true
			 	    });
			 	    new $.fn.dataTable.FixedColumns(table, {leftColumns: 2});
		  	    }
	  	   });
		}
    </script>
    <!-- End Of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<html:form action="/DashboardUser"> 
		<html:hidden name="DashboardUserForm" property="task"/>
		<html:hidden name="DashboardUserForm" property="tmpId"/>
		<html:hidden name="DashboardUserForm" property="tmpValue"/>
		
		<section class="content-header">
			<h1>Dashboard <small>Control panel</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Dashboard</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
					<section class="col-lg-7 connectedSortable">
						<div class="box box-primary">
							<div class="box-header">
								<i class="ion ion-clipboard"></i>
								<h3 class="box-title">To Do List Activity</h3>
								<div class="box-tools pull-right">
									<ul class="pagination pagination-sm inline">
										<li><a href="#">&laquo;</a></li>
										<li><a href="#">1</a></li>
										<li><a href="#">2</a></li>
										<li><a href="#">3</a></li>
										<li><a href="#">&raquo;</a></li>
									</ul>
								</div>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<ul class="todo-list">
										<!-- todo text -->
										<!-- <span class="text">Design a nice theme</span>  -->
										<!-- Emphasis label -->
										<!-- <small class="label label-success">
											<i class="fa fa-clock-o"></i> 2 mins
										</small>  -->
										<!-- todolist -->
										<logic:notEmpty name="listActivity">
											<logic:iterate id="iter" name="listActivity">
												<li>
													<span class="handle"> 
														<i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
													</span>	
						                			<span class="text"><bean:write name="iter" property="activityName"/> | <bean:write name="iter" property="taskName"/> </span>
						                   
								                    <!-- General tools such as play or pause or finish or delete-->
								                    <div class="tools">
														<logic:notEqual name="iter" property="activityStatus" value="1">
															<i class="fa fa-play" onclick="activityDetail('addActivity','<bean:write name="iter" property="activityId"/>','1')"></i>
														</logic:notEqual>
														<logic:equal name="iter" property="activityStatus" value="1">
															<i class="fa fa-pause" onclick="activityDetail('pauseActivity','<bean:write name="iter" property="activityId"/>','2')"></i> 
														</logic:equal>
														<logic:equal name="iter" property="activityStatus" value="1">
															<i class="fa fa-check" onclick="activityDetail('finishActivity','<bean:write name="iter" property="activityId"/>','4')"></i>
														</logic:equal>
														<logic:notEqual name="iter" property="activityStatus" value="1">	
															<i class="fa fa-trash-o" onclick="flyToEditDelete('delete','<bean:write name="iter" property="activityId"/>')"></i>
														</logic:notEqual>
													</div>
												</li>
											 </logic:iterate>
										</logic:notEmpty>
										<logic:empty name="listActivity">
											<span class="handle"> 
												<i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
											</span>	
											<span class="text">No List Activity</span>
										</logic:empty>
									
								</ul>
							</div>
							<!-- /.box-body -->
							<div class="box-footer clearfix no-border">
								<button class="btn btn-default pull-right" onClick="flyToPage('chooseActivity')">
									<i class="fa fa-plus"></i> Add item
								</button>
							</div>
						</div>
					</section>
					<section class="col-lg-5 connectedSortable">
						<div class="box box-solid bg-green-gradient">
							<div class="box-header"><i class="fa fa-calendar"></i>
							<h3 class="box-title">Calendar</h3>
							<div class="pull-right box-tools">
			                    <div class="btn-group">
			                    	<button class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bars"></i></button>
			                      	<ul class="dropdown-menu pull-right" role="menu">
				                        <li><a href="#">Add new event</a></li>
				                        <li><a href="#">Clear events</a></li>
				                        <li class="divider"></li>
				                        <li><a href="#">View calendar</a></li>
			                      	</ul>
			                    </div>
		                    	<button class="btn btn-success btn-sm" data-widget="collapse"><i class="fa fa-minus"></i></button>
		                    	<button class="btn btn-success btn-sm" data-widget="remove"><i class="fa fa-times"></i></button>
		                  	</div>
		                </div>
		                <div class="box-body no-padding">
		                	<div id="calendar" style="width: 100%"></div>
		                </div>
		            </section>
		        </div>
		        
		        <!-- Activity Progress -->
             <div class="box">
                <div class="box-header">
					<i class="ion ion-clipboard"></i>
                  	<h3 class="box-title">Activity Progress</h3>
                  	<br><br>Search by Date : <br><br>
                  	<table width="370px">
                  		<tr>
                  			<td>
	                  			<div class="input-group" style="width:220px; height:20px; background-color:yellow;">
			                 		<div class="input-group-addon">
				           				<i class="fa fa-calendar"></i>
				           			</div>
				           			<html:text name="DashboardUserForm" property="currentDate" styleClass="form-control pull-right" styleId="datepicker_activitydate"/>		
								</div>
                  			</td>
                  			<td>
                  				<input type="button" class="btn bg-olive" style="height:32px" onclick="loadActivityProgress(false)" value='Search'/>
								<input type="button" class="btn bg-olive" style="height:32px" onclick="loadActivityProgress(true)" value='Today'/>
                  			</td>			
                  		</tr>
                  	</table>
					<div class="box-body no-padding">
                  	  <center><h3 id="date_activitydate"></h3></center>
	                  <table id="table-1" class="display" cellspacing="0" width="100%" height="100%">
	                  </table>
	                </div><!-- /.box-body -->
	            </div>
            </div>
	        <!-- End of Activity Progress -->
       </section>
	</html:form>	
</body>
</html>
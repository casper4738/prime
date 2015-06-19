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
    <link href="resources/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/fullcalendar/fullcalendar.print.css" rel="stylesheet" type="text/css" media='print' />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini" onload="fLoad()">
	<div class="wrapper">
		<jsp:include page="/content/Header.jsp"></jsp:include>
		<div class="content-wrapper">
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
						<html:form action="/DashboardUser"> 
							<html:hidden name="DashboardUserForm" property="task"/>
							<html:hidden name="DashboardUserForm" property="tmpId"/>
							<html:hidden name="DashboardUserForm" property="tmpValue"/>
						</html:form>	
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
														<!-- <div id="start" style="display: inline"> -->
															<i class="fa fa-play" onclick="insertActivityDetail('addActivity','<bean:write name="iter" property="activityId"/>','1')"></i>
														<!-- </div> 
														<div id="pause" style="display: none"> -->
															<i class="fa fa-pause" onclick="pauseActivity('<bean:write name="iter" property="activityId"/>')"></i> 
														<!-- </div>	 -->
														<i class="fa fa-check"></i><i class="fa fa-trash-o" onclick="flyToEditDelete('delete','<bean:write name="iter" property="activityId"/>')"></i>
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
				<!-- Progress box -->
                <div class="box box-success">
                	<div class="box-header">
	                	<h3 class="box-title">Progress Bar</h3>
	                	<div class="box-tools pull-right" data-toggle="tooltip">
	                    	<i class="fa fa-square text-green" title="Start"></i>
	                   		<i class="fa fa-square text-red" title="Pause"></i>
		                </div>
	                	<table>
               				<tr>
               					<td>
               						<html:button property="" value="<"></html:button>
               						<html:button property="" value=">"></html:button>
               						<html:button property="" value="today"></html:button>
               					</td>
               					<td colspan="10">
               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               					</td>
               					<td colspan="8" align="center"><h1><div id="day"></div></h1></td>
               				</tr>
                  		</table>
                	</div>
	               	<!-- <div class="box-body chat" id="chat-box"> -->
	               	<div class="table-progress">
              			<table border="1" style="background-color: #00c0ef; width: 2500px; height: 20px" id="tableProgress">	
               				<tr>
               					<td style="width:100px">&nbsp;</td>
               					<td align="center" style="width:100px">00.00</td>
               					<td align="center" style="width:100px">01.00</td>
               					<td align="center" style="width:100px">02.00</td>
               					<td align="center" style="width:100px">03.00</td>
               					<td align="center" style="width:100px">04.00</td>
               					<td align="center" style="width:100px">05.00</td>
               					<td align="center" style="width:100px">06.00</td>
               					<td align="center" style="width:100px">07.00</td>
               					<td align="center" style="width:100px">08.00</td>
               					<td align="center" style="width:100px">09.00</td>
               					<td align="center" style="width:100px">10.00</td>
               					<td align="center" style="width:100px">11.00</td>
               					<td align="center" style="width:100px">12.00</td>
               					<td align="center" style="width:100px">13.00</td>
               					<td align="center" style="width:100px">14.00</td>
               					<td align="center" style="width:100px">15.00</td>
               					<td align="center" style="width:100px">16.00</td>
               					<td align="center" style="width:100px">17.00</td>
               					<td align="center" style="width:100px">18.00</td>
               					<td align="center" style="width:100px">19.00</td>
               					<td align="center" style="width:100px">20.00</td>
               					<td align="center" style="width:100px">21.00</td>
               					<td align="center" style="width:100px">22.00</td>
               					<td align="center" style="width:100px">23.00</td>
               					<td align="center" style="width:100px">24.00</td>
               				</tr>
               				<tr>
               					<td>Activity 1</td>
               					<td colspan=25>
               						<div class="progress progress-m active">
					                  <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" style="margin-left:32%;width:6.3%"/>
					                </div>
					                <div class="progress progress-m active">
					                  <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" style="margin-left:6.9%;width:9.8%"/>
               						</div>
               					</td>
               				</tr>
               			</table>
                   </div><!-- /.table-progress -->
               </div><!-- /.box (progress box) -->
            </section>
		</div>
		<jsp:include page="/content/Footer.jsp"></jsp:include>
	</div>

	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	
	<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>
	
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<!-- 
	<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	 -->
	<!-- progress -->
    <!-- <script src="resources/plugins/jQuery/jQuery-2.1.4.min.js"></script> -->
    <script src="resources/prime.js"></script>
    <script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- <script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js" type="text/javascript"></script> -->
    <script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='resources/plugins/fastclick/fastclick.min.js'></script>
    <script src="resources/dist/js/app.min.js" type="text/javascript"></script>
    <script src="resources/dist/js/demo.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
	<!-- progress -->
	<script src="resources/plugins/morris/morris.min.js" type="text/javascript"></script>
	<script src="resources/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
	<script src="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
	<script src="resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
	<script src="resources/plugins/knob/jquery.knob.js" type="text/javascript"></script>
	<script src="resources/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>111	
	<script src="resources/dist/js/pages/dashboard.js" type="text/javascript"></script>
	<script type="text/javascript">
		var date = new Date();
    	var d = date.getDate();
        var month = new Array();
	    	month[0] = "January";
	    	month[1] = "February";
	    	month[2] = "March";
	    	month[3] = "April";
	    	month[4] = "May";
	    	month[5] = "June";
	    	month[6] = "July";
	    	month[7] = "August";
	    	month[8] = "September";
	    	month[9] = "October";
	    	month[10] = "November";
	    	month[11] = "December";
    	var m = month[date.getMonth()],
            y = date.getFullYear();
    	
    	function fLoad(){
    		document.getElementById("day").innerHTML=d+"-"+m+"-"+y
    	}
    	
    	function insertActivity() {
    	    var table = document.getElementById("tableProgress");
    	    var row = table.insertRow(1);
    	    var cell = new Array();
    	    for(var i=0; i<=1500;i++){
    	    	cell[i] = row.insertCell(i);
    	    }
    	    cell[0].innerHTML = "Activity 1";
    	    /* document.getElementById("pause").style.display="inline"
    	    document.getElementById("start").style.display="none" */
    	}
    	
    	function insertActivityDetail(task,activityId,status){
    		document.forms[0].task.value = task;
    		document.forms[0].tmpId.value = activityId;
    		document.forms[0].tmpValue.value = status;
    		document.forms[0].submit();
    	}
    	
    	function pauseActivity() {
    	    document.getElementById("pause").style.display="none"
    	    document.getElementById("start").style.display="inline"
    	}
	</script>
</body>
</html>
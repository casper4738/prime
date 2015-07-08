<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html> 
<html>
<head> 
<!-- CSS -->
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
   	<link href="resources/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/fullcalendar/fullcalendar.print.css" rel="stylesheet" type="text/css" media='print' />
    <link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/extensions/FixedColumns/css/dataTables.fixedColumns.min.css" rel="stylesheet" type="text/css" />
    
    <!-- JS -->
    <script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='resources/plugins/fastclick/fastclick.min.js'></script>
    <script src="resources/dist/js/app.min.js" type="text/javascript"></script>
    <script src="resources/plugins/moment/moment.min.js" type="text/javascript"></script>
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
	 	    
           //Load Activity To Do List
           loadActivityToDoList();
           
  		   //Load Activity Progress Timetable
  		   loadActivityProgress(true);
  		   
  		   //Reload Chart Every 5 Minutes
	   		setInterval(loadActivityProgress, 30 * 60 * 1000); //30 Menit
  		   
		});
    	
		function openModalHandler(tmpTask){
			var tmpTable ="activityList";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable, $('#result'));
		}
		
		//##.Activity Detail
		function loadActivityToDoList(){
	  		$('#board-todolist').html(PAGE_LOADING);
			$('#board-todolist').load("<%=Constants.PAGES_LIST[Constants.Page.USER_DASHBOARD]%>", "task=refreshToDoList", function( response, status, xhr ) {
				//---.Show Some Respect For Error Status
				if(status == "error"){
					$('#board-todolist').html(PAGE_LOAD_ERROR);
				} else {
					//Do Nothing, Success
				}
			});
		}
		
		//##.Activity Progress
		function loadActivityProgress(isToday){
			//Set Current Date
			var tmpDate;
			
			switch(isToday){
				case false :
				  	tmpDate = $('#datepicker_activitydate').datepicker('getDate');
					break;
				case true  :
				  	tmpDate = new Date();
					break;
			}
	        var tmpMonthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
			var d = tmpDate.getDate();
			var m = tmpDate.getMonth() + 1;
			var y = tmpDate.getFullYear();
			var tmpRefreshDate = d + "/" + m + "/" + y;
			$('#datepicker_activitydate').datepicker('setDate', tmpDate);
			$('#date_activitydate').html("<b>" + ((d < 10) ? ("0" + d) : d) + " " + tmpMonthList[m - 1] + " " + y + "</b>");    
			
	  		//Do Login Data checking
	  		$('#table-wrapper').html(PAGE_LOADING);
	  		$('#table-wrapper').load("<%=Constants.PAGES_LIST[Constants.Page.USER_DASHBOARD]%>", "task=refreshActivityProgress&currentDate=" + tmpRefreshDate, function( response, status, xhr ) {
								//---.Show Some Respect For Error Status
								if(status == "error"){
									$('#table-wrapper').html(PAGE_LOAD_ERROR);
								} else {
					  	    	    var table = $('#table-1').dataTable({
					  										 			ordering 		: false,
					  										 			paging    		: false,
					  										 			searching 		: false,
					  										 			info	  		: false,
					  										 			scrollY	  		: "250px",
					  										 		    scrollX	  		: "100%",
					  										 		    scrollCollapse	: true,
					  										 		 	columnDefs: [
							  										 		            { width: '1%' , targets: 0 },
							  										 		            { width: '3%' , targets: 1 },
							  										 		            { width: '15%', targets: 2 },
							  										 		            { width: '3%' , targets: 3 }
							  										 		        ],
					  													language  		: {"emptyTable":  "<center><%=Constants.Response.TABLE_HEAD_EMPTY %></center>"}
					  										 	    });
						  		  	$('#table-wrapper').css('min-height','200');
						  		    new $.fn.dataTable.FixedColumns(table, {leftColumns: 4});
								}
	  		});
		}
		
		//##.Calendar Handling
		$(function () {
        	//.Initialize the external events
	        function ini_events(ele) {
	          ele.each(function () {
	            // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
	            // it doesn't need to have a start or end
	            var eventObject = {
	              title: $.trim($(this).text()) // use the element's text as the event title
	            };
	
	            // store the Event Object in the DOM element so we can get to it later
	            $(this).data('eventObject', eventObject);
	
	            // make the event draggable using jQuery UI
	            $(this).draggable({
	              zIndex: 1070,
	              revert: true, // will cause the event to go back to its
	              revertDuration: 0  //  original position after the drag
	            });
	          });
	        }
        	ini_events($('#external-events div.external-event'));


        	//.Date for the calendar events	
		    var date = new Date();
		    var d = date.getDate();
		    var m = date.getMonth();
			var y = date.getFullYear();

			$('#calendar').fullCalendar({
		          header: {
			            left: '',
			            center: 'title',
			          },
			          buttonText: {
			            today: 'today',
			            month: 'month',
			          },
			          eventClick:  function(event, jsEvent, view) {
			              $('#modalTitle').html(event.title);
			              $('#modalBody').html(event.description);
			              $('#eventUrl').attr('href',event.url);
			              $('#fullCalModal').modal();
			          },
			          
			          //Random default events
			          events: [
							<% 
								List<String> arrHoliday = (ArrayList) request.getAttribute("calendar");
								for(int a = 0; a<arrHoliday.size();a++){
									out.println(arrHoliday.get(a)); 
								}
							%>
			          ],
			          
			          editable: true,
			          droppable: true, // this allows things to be dropped onto the calendar !!!
			          drop: function (date, allDay) { // this function is called when something is dropped
				            // retrieve the dropped element's stored Event Object
				            var originalEventObject = $(this).data('eventObject');
			
				            // we need to copy it, so that multiple events don't have a reference to the same object
				            var copiedEventObject = $.extend({}, originalEventObject);
			
				            // assign it the date that was reported
				            copiedEventObject.start = date;
				            copiedEventObject.allDay = allDay;
				            copiedEventObject.backgroundColor = $(this).css("background-color");
				            copiedEventObject.borderColor = $(this).css("border-color");
			
				            // render the event on the calendar
				            // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
				            $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
			
				            // is the "remove after drop" checkbox checked?
				            if ($('#drop-remove').is(':checked')) {
				              // if so, remove the element from the "Draggable Events" list
				              $(this).remove();
				            }
			          }
			});
      });
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
					<section class="col-lg-7 connectedSortable" id="board-todolist">
						<!-- To Load DashboardToDoList.jsp -->
					</section>
					<section class="col-lg-5 connectedSortable">
						<div class="box box-primary">
			               <div class="box-body no-padding">
			                 <!-- THE CALENDAR -->
			                 <div id="calendar"></div>
			               </div><!-- /.box-body -->
			             </div><!-- /. box -->
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
	                  	<div id="table-wrapper">
	                  	</div>
	                </div><!-- /.box-body -->
	            </div>
            </div>
	        <!-- End of Activity Progress -->
       </section>
	</html:form>	
	
	
	<div id="fullCalModal" class="modal fade">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
	                <h4 id="modalTitle" class="modal-title"></h4>
	            </div>
	            <div id="modalBody" class="modal-body"></div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>
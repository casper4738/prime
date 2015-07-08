<%@page import="prime.constants.Constants"%>
<%@page import="prime.admin.employee.EmployeeBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ page import="prime.admin.employee.EmployeeBean" %>
<%@ page import="prime.admin.user.UserBean" %>
<%
	UserBean tmpUserData = (UserBean)request.getSession().getAttribute(Constants.Session.Userdata);
	EmployeeBean tmpEmpData = (EmployeeBean)request.getSession().getAttribute(Constants.Session.Employeedata);
%>
  
<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>PRIMEprogram</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<!-- CSS -->
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
   	<link href="resources/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/fullcalendar/fullcalendar.print.css" rel="stylesheet" type="text/css" media='print' />
    <link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    
    <!-- JS -->
    <script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='resources/plugins/fastclick/fastclick.min.js'></script>
    <script src="resources/dist/js/app.min.js" type="text/javascript"></script>
    <script src="resources/plugins/moment/moment.min.js" type="text/javascript"></script>
    <script src="resources/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
    <script type="text/javascript">
      $(document).ready(function(){
    	  var tmpImage = '<%=tmpEmpData.getConvertedFilePic()%>';
    	  if(tmpImage == "null"){
        	  $("#profpic").attr("src", "<%=Constants.PATH_USERNOIMAGE%>");
    	  } else {
        	  $("#profpic").attr("src","data:image/;base64,<%=tmpEmpData.getConvertedFilePic()%>");  
    	  } 
      });
    
      $(function () {
        /* initialize the external events
         -----------------------------------------------------------------*/
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


        /* initialize the calendar
         -----------------------------------------------------------------*/
        //Date for the calendar events (dummy data)	       
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
							List<String> arrHoliday = (ArrayList) request.getAttribute("teslist");
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
        
        /* ADDING EVENTS */
        var currColor = "#3c8dbc"; //Red by default
        //Color chooser button
        var colorChooser = $("#color-chooser-btn");
        $("#color-chooser > li > a").click(function (e) {
          e.preventDefault();
          //Save color
          currColor = $(this).css("color");
          //Add color effect to button
          $('#add-new-event').css({"background-color": currColor, "border-color": currColor});
        });
        $("#add-new-event").click(function (e) {
          e.preventDefault();
          //Get value and make sure it is not null
          var val = $("#new-event").val();
          if (val.length == 0) {
            return;
          }

          //Create events
          var event = $("<div />");
          event.css({"background-color": currColor, "border-color": currColor, "color": "#fff"}).addClass("external-event");
          event.html(val);
          $('#external-events').prepend(event);

          //Add draggable funtionality
          ini_events(event);

          //Remove event from text input
          $("#new-event").val("");
        });
      });
    </script>
    <!-- End Of JS -->
    
</head>

<body class="skin-blue sidebar-mini">
	<section class="content">
	<div class="row">
		<section class="col-lg-5">
		<div class="box box-primary">
			<div class="box-header"><h4 class="box-title">Welcome, <%=tmpEmpData.getEmployeeName()%></h4></div>
                 <div class="box-tools">
				 <div class="box-body no-padding">
					<center><img class="photo" id="profpic" width="320px" height="320px"/></center>
				 </div>
			</div>
			</div>
		</section>

           <div class="col-lg-7">
             <div class="box box-primary">
               <div class="box-body no-padding">
                 <!-- THE CALENDAR -->
                 <div id="calendar"></div>
               </div><!-- /.box-body -->
             </div><!-- /. box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
     </section>
      
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

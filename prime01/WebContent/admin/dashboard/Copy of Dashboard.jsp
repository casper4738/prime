<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="resources/calendar/css/frontierCalendar/jquery-frontier-cal-1.3.2.css" />
	<link rel="stylesheet" type="text/css" href="resources/calendar/css/colorpicker/colorpicker.css" />
	<link rel="stylesheet" type="text/css" href="resources/calendar/css/jquery-ui/smoothness/jquery-ui-1.8.1.custom.css" />
	
	<script src="resources/plugins/morris/morris.min.js" type="text/javascript"></script>
</head>

<body class="skin-blue sidebar-mini">
	<section class="content">
		<div class="row">
			<section class="col-lg-7 connectedSortable">
				<div class="login-photo">
					<h3 class="photo">Welcome, Alexander</h3>
					<img class="photo" src="image/resize-Lighthouse.jpg" />
				</div>


			</section>

			<section class="col-lg-5 connectedSortable">
				<div class="box box-solid bg-green-gradient">
					<div class="box-header">
						<i class="fa fa-calendar"></i>
						<h3 class="box-title">Calendar</h3>
						<div class="pull-right box-tools">
							<div class="btn-group">
								<button class="btn btn-success btn-sm dropdown-toggle"
									data-toggle="dropdown">
									<i class="fa fa-bars"></i>
								</button>
								<ul class="dropdown-menu pull-right" role="menu">
									<li><a href="#">Add new event</a></li>
									<li><a href="#">Clear events</a></li>
									<li class="divider"></li>
									<li><a href="#">View calendar</a></li>
								</ul>
							</div>
							<button class="btn btn-success btn-sm" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button class="btn btn-success btn-sm" data-widget="remove">
								<i class="fa fa-times"></i>
							</button>
						</div>
						<!-- /. tools -->
					</div>
					<!-- /.box-header -->
					<div class="box-body no-padding">
						<div id="calendar" style="width: 100%"></div>
					</div>
					<!-- /.box-body -->
					<div class="box-footer text-black">
						CALENDAR
						<!-- /.row -->
					</div>
				</div>
				<!-- /.box -->
			</section>
		</div>
	</section>


	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>

	<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js"
		type="text/javascript"></script>

	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<script src="resources/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<script src="resources/plugins/morris/morris.min.js"
		type="text/javascript"></script>
	<script src="resources/plugins/sparkline/jquery.sparkline.min.js"
		type="text/javascript"></script>
	<script
		src="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"
		type="text/javascript"></script>
	<script
		src="resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"
		type="text/javascript"></script>
	<script src="resources/plugins/knob/jquery.knob.js"
		type="text/javascript"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"
		type="text/javascript"></script>

	<script src="resources/plugins/daterangepicker/daterangepicker.js"
		type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js"
		type="text/javascript"></script>
	<script
		src="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"
		type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js"
		type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/pages/dashboard.js"
		type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	
	
	<script type="text/javascript" src="resources/calendar/js/jquery-core/jquery-1.4.2-ie-fix.min.js"></script>

	<!-- Include JQuery UI (Required for calendar plugin.) -->
	<script type="text/javascript" src="resources/calendar/js/jquery-ui/smoothness/jquery-ui-1.8.1.custom.min.js"></script>
	
	<!-- Include color picker plugin (Not required for calendar plugin. Used for example.) -->
	<script type="text/javascript" src="resources/calendar/js/colorpicker/colorpicker.js"></script>
	
	<!-- Include jquery tooltip plugin (Not required for calendar plugin. Used for example.) -->
	<script type="text/javascript" src="resources/calendar/js/jquery-qtip-1.0.0-rc3140944/jquery.qtip-1.0.js"></script>
	
	<!--
		(Required for plugin)
		Dependancies for JQuery Frontier Calendar plugin.
	    ** THESE MUST BE INCLUDED BEFORE THE FRONTIER CALENDAR PLUGIN. **
	-->
	<script type="text/javascript" src="resources/calendar/js/lib/jshashtable-2.1.js"></script>
	
	<!-- Include JQuery Frontier Calendar plugin -->
	<script type="text/javascript" src="resources/calendar/js/frontierCalendar/jquery-frontier-cal-1.3.2.min.js"></script>
</body>
</html>

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

				<div class="box box-primary">
					<div class="box-header">
						<i class="ion ion-clipboard"></i>
						<h3 class="box-title">To Do List</h3>
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
							<li>
								<!-- drag handle --> <span class="handle"> <i
									class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
							</span> <!-- checkbox --> <input type="checkbox" value="" name="" /> <!-- todo text -->
								<span class="text">Design a nice theme</span> <!-- Emphasis label -->
								<small class="label label-danger"><i
									class="fa fa-clock-o"></i> 2 mins</small> <!-- General tools such as edit or delete-->
								<div class="tools">
									<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
								</div>
							</li>
							<li><span class="handle"> <i class="fa fa-ellipsis-v"></i>
									<i class="fa fa-ellipsis-v"></i>
							</span> <input type="checkbox" value="" name="" /> <span class="text">Make
									the theme responsive</span> <small class="label label-info"><i
									class="fa fa-clock-o"></i> 4 hours</small>
								<div class="tools">
									<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
								</div></li>
							<li><span class="handle"> <i class="fa fa-ellipsis-v"></i>
									<i class="fa fa-ellipsis-v"></i>
							</span> <input type="checkbox" value="" name="" /> <span class="text">Let
									theme shine like a star</span> <small class="label label-warning"><i
									class="fa fa-clock-o"></i> 1 day</small>
								<div class="tools">
									<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
								</div></li>
							<li><span class="handle"> <i class="fa fa-ellipsis-v"></i>
									<i class="fa fa-ellipsis-v"></i>
							</span> <input type="checkbox" value="" name="" /> <span class="text">Let
									theme shine like a star</span> <small class="label label-success"><i
									class="fa fa-clock-o"></i> 3 days</small>
								<div class="tools">
									<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
								</div></li>
							<li><span class="handle"> <i class="fa fa-ellipsis-v"></i>
									<i class="fa fa-ellipsis-v"></i>
							</span> <input type="checkbox" value="" name="" /> <span class="text">Check
									your messages and notifications</span> <small
								class="label label-primary"><i class="fa fa-clock-o"></i>
									1 week</small>
								<div class="tools">
									<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
								</div></li>
							<li><span class="handle"> <i class="fa fa-ellipsis-v"></i>
									<i class="fa fa-ellipsis-v"></i>
							</span> <input type="checkbox" value="" name="" /> <span class="text">Let
									theme shine like a star</span> <small class="label label-default"><i
									class="fa fa-clock-o"></i> 1 month</small>
								<div class="tools">
									<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
								</div></li>
						</ul>
					</div>
					<!-- /.box-body -->
					<div class="box-footer clearfix no-border">
						<button class="btn btn-default pull-right">
							<i class="fa fa-plus"></i> Add item
						</button>
					</div>
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
						<div class="row">
							<div class="col-sm-6">
								<!-- Progress bars -->
								<div class="clearfix">
									<span class="pull-left">Task #1</span> <small
										class="pull-right">90%</small>
								</div>
								<div class="progress xs">
									<div class="progress-bar progress-bar-green"
										style="width: 90%;"></div>
								</div>

								<div class="clearfix">
									<span class="pull-left">Task #2</span> <small
										class="pull-right">70%</small>
								</div>
								<div class="progress xs">
									<div class="progress-bar progress-bar-green"
										style="width: 70%;"></div>
								</div>
							</div>
							<!-- /.col -->
							<div class="col-sm-6">
								<div class="clearfix">
									<span class="pull-left">Task #3</span> <small
										class="pull-right">60%</small>
								</div>
								<div class="progress xs">
									<div class="progress-bar progress-bar-green"
										style="width: 60%;"></div>
								</div>

								<div class="clearfix">
									<span class="pull-left">Task #4</span> <small
										class="pull-right">40%</small>
								</div>
								<div class="progress xs">
									<div class="progress-bar progress-bar-green"
										style="width: 40%;"></div>
								</div>
							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
					</div>
				</div>
				<!-- /.box -->
			</section>
		</div>
		<h3>Welcome, Fandy</h3>
		<img src="image/resize-Lighthouse.jpg" />
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
</body>
</html>

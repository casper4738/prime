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
<link href="resources/plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />
<link href="resources/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
<link href="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
<link href="resources/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
<link href="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header">
			<a href="index2.html" class="logo">
				<span class="logo-lg"><b>PRIME</b>PROGRAM</span>
			</a>
			
			<nav class="navbar navbar-static-top" role="navigation">
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<li class="dropdown notifications-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-bell-o"></i> <span class="label label-warning">10</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 10 notifications</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li><a href="#"> <i class="fa fa-users text-aqua"></i>
												5 new members joined today
										</a></li>
										<li><a href="#"> <i class="fa fa-warning text-yellow"></i>
												Very long description here that may not fit into the page
												and may cause design problems
										</a></li>
										<li><a href="#"> <i class="fa fa-users text-red"></i>
												5 new members joined
										</a></li>

										<li><a href="#"> <i
												class="fa fa-shopping-cart text-green"></i> 25 sales made
										</a></li>
										<li><a href="#"> <i class="fa fa-user text-red"></i>
												You changed your username
										</a></li>
									</ul>
								</li>
								<li class="footer"><a href="#">View all</a></li>
							</ul></li>
						
						<li class="dropdown user user-menu"><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
							<img src="resources/dist/img/user2-160x160.jpg" class="user-image" alt="User Image" />
							<span class="hidden-xs">Alexander</span>
							</a>
							<ul class="dropdown-menu">
							<li class="user-header"><img src="resources/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image" />
								<p>Alexander<small>Administrator</small></p></li>
							<li class="user-footer">
								<div class="pull-left"><a href="#" class="btn btn-default btn-flat">Profile</a></div>
								<div class="pull-left"><a href="#" class="btn btn-default btn-flat">Change Password</a></div>
								<div class="pull-left"><a href="#" class="btn btn-default btn-flat">Sign out</a></div>
							</li>
						</ul></li>
					</ul>
				</div>
			</nav>
		</header>
		<aside class="main-sidebar">
			<section class="sidebar">
				<div class="user-panel">
					<div class="pull-left image">
						<img src="resources/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image" />
					</div>
					<div class="pull-left info">
						<p>Alexander</p>
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					</div>
				</div>
				<ul class="sidebar-menu">
					<li class="header">MAIN MENU</li>
					<li><a href="#"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>Manage Admin</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>Manage Employee</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>Manage Division</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>Manage Position</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>Manage Role</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>Manage Holidays</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>View Log</span></a></li>
					<li><a href="#"><i class="fa fa-table"></i><span>General Setting</span></a></li>
				</ul>
			</section>
		</aside>

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
									<li><span class="handle"> <i
											class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
									</span> <input type="checkbox" value="" name="" /> <span class="text">Make
											the theme responsive</span> <small class="label label-info"><i
											class="fa fa-clock-o"></i> 4 hours</small>
										<div class="tools">
											<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
										</div></li>
									<li><span class="handle"> <i
											class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
									</span> <input type="checkbox" value="" name="" /> <span class="text">Let
											theme shine like a star</span> <small class="label label-warning"><i
											class="fa fa-clock-o"></i> 1 day</small>
										<div class="tools">
											<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
										</div></li>
									<li><span class="handle"> <i
											class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
									</span> <input type="checkbox" value="" name="" /> <span class="text">Let
											theme shine like a star</span> <small class="label label-success"><i
											class="fa fa-clock-o"></i> 3 days</small>
										<div class="tools">
											<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
										</div></li>
									<li><span class="handle"> <i
											class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
									</span> <input type="checkbox" value="" name="" /> <span class="text">Check
											your messages and notifications</span> <small
										class="label label-primary"><i class="fa fa-clock-o"></i>
											1 week</small>
										<div class="tools">
											<i class="fa fa-edit"></i> <i class="fa fa-trash-o"></i>
										</div></li>
									<li><span class="handle"> <i
											class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
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
					</section>
				</div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<footer class="main-footer">
			<div class="pull-right hidden-xs">
				<b>Version</b> 2.0
			</div>
			<strong>Copyright &copy; 2014-2015 <a
				href="http://almsaeedstudio.com">Almsaeed Studio</a>.
			</strong> All rights reserved.
		</footer>
	</div>

	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	
	<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>
	
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	
	<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	
	<script src="resources/plugins/morris/morris.min.js" type="text/javascript"></script>
	<script src="resources/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
	<script src="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
	<script src="resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
	<script src="resources/plugins/knob/jquery.knob.js" type="text/javascript"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js" type="text/javascript"></script>
	
	<script src="resources/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/pages/dashboard.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>
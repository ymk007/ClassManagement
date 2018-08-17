<%@page import="com.hx.pojo.Curriculum"%>
<%@page import="java.util.List"%>
<%@page import="com.hx.pojo.User"%>
<%@page import="com.hx.service.UserService"%>
<%@page import="com.hx.service.impl.UserServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <base href="<%=basePath%>"> 
  <title>AdminLTE 2 | Dashboard</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
  <!-- Morris chart -->
  <link rel="stylesheet" href="bower_components/morris.js/morris.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="bower_components/jvectormap/jquery-jvectormap.css">
  <!-- Date Picker -->
  <link rel="stylesheet" href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="bower_components/bootstrap-daterangepicker/daterangepicker.css">
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

	<link type="text/css" rel="stylesheet" href="test/jeDate-test.css">
   <link type="text/css" rel="stylesheet" href="skin/jedate.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
	<script type="text/javascript" src="src/jedate.js"></script>
<c:if test="${!empty changeSucc}">
	<script type="text/javascript">
	function onload() {
		alert("修改成功！");
	}
	</script>
</c:if>
<c:if test="${!empty changeErr}">
	<script type="text/javascript">
		function onload() {
			alert("修改失败，请确认你的密码是否一致！");
		}
	</script>
</c:if>
</head>
<body class="hold-transition skin-blue sidebar-mini" onload="onload()">
<%
	
%>

<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="index.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>课时管理平台</b></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
           
          </li>
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
           
          </li>
          <!-- Tasks: style can be found in dropdown.less -->
          <c:if test="${empty user}">
			<li class="dropdown user user-menu">
				<a href="pages/examples/login.html" class="dropdown-toggle">
					<i class="fa fa-spinner"></i>
					登录
				</a>
			</li>
			</c:if>
          <c:if test="${!empty user}">
          <li class="dropdown user user-menu" >
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
              <span class="hidden-xs">${user.userName}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="${user.headPhoto}" class="img-circle" alt="User Image">

                <p>
                  	${user.userName}
                  <small>生日：${user.birthday}</small>
                </p>
              </li>
              <!-- Menu Body -->
              <li class="user-body">
                <!-- /.row -->
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#aaa">
		                <i class="fa fa-wrench"></i>修改密码
		              </button>
		              
                  <!--<a href="#" class="btn btn-default btn-flat"><i class="fa fa-wrench"></i>修改密码</a>-->
                </div>
                <div class="pull-right">
                	<a href="user/logout.do">
	                	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal-info">
			                <i class="fa fa-power-off"></i>　注销　
			              </button>
		              </a>
                </div>
              </li>
            </ul>
          </li>
            </c:if>
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <!--修改密码模态框-->
  <form action="user/changePassword.do?userId=${user.userId}" method="post">
  <div class="modal modal-info fade" id="aaa" >
	  <div class="modal-dialog">
	    <div class="modal-content" style="width: 80%; margin: auto;">
	      <div class="modal-header">
	        	修改密码
	      </div>
	      <div class="modal-body">
	        <div class="form-group has-feedback" style="width: 60%; margin: 10px auto;">
		        	用户名：${user.userName}
		      </div>
		      <div class="form-group has-feedback" style="width: 60%; margin:10px auto;">
		        <input type="password" class="form-control" placeholder="旧密码" name="oldPwd">
		      </div>
		      <div class="form-group has-feedback" style="width: 60%; margin:10px auto;">
		        <input type="password" class="form-control" placeholder="新密码" name="newPwd">
		      </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
	        <button type="submit" class="btn btn-outline">确认修改</button>
	      </div>
	    </div>
	    <!-- .modal-content -->
	  </div>
	  <!-- .modal-dialog -->
	</div>
	</form>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
     
      <div class="user-panel">
       <c:if test="${empty user}"><div  style="height: 20px;"><a href="pages/examples/login.html">请先登录！</a></div></c:if>
       <c:if test="${!empty user}">
        <div class="pull-left image">
          <img src="${user.headPhoto}" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>${user.userName}</p>
          <a href="#"><i class="fa fa-circle text-success"></i>在线</a>
        </div>
        </c:if>
      </div>
      
      <!-- search form -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="搜索...">
          <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">导航</li>
        <li class="active treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i> <span>课时管理</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li class="active"><a href="curr/GotoAddCourse.do"><i class="glyphicon glyphicon-pencil"></i>课时登记</a></li>
            <li><a href="index2.html"><i class="glyphicon glyphicon-time"></i>时间分类</a></li>
          </ul>
        </li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
      	<a href="index.jsp"><span class="glyphicon glyphicon-home" style="font-size: 20px;"></span>
        	首页</a>
        <small>控制台</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="index.jsp"><i class="fa fa-dashboard"></i>首页</a></li>
        <li class="active">
        <c:if test="${modifi=='modification.jsp'}">信息修改</c:if>
        <c:if test="${empty modifi}">课时信息</c:if>
        <c:if test="${modifi=='addCourse.jsp'}">新增信息</c:if>	
        </li>
      </ol>
      
    </section>
    	
    
    <!--信息展示-->
     <section class="content">
     <input type="hidden" class="jeinput" id="test02" placeholder="2018-08" name="time" />
      <c:if test="${!empty modifi}">
     	<iframe  src="<%=path %>/${modifi}" frameborder="0" width="100%" height="660px" scrolling="no"></iframe>
     </c:if>
     <c:if test="${empty modifi}">	
		<iframe  src="<%=path %>/showCourse.jsp" frameborder="0" width="100%" height="660px" scrolling="no"></iframe>
     </c:if>   
    </section>
   </div>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>版本号</b> 2.4.0
    </div>
    <strong>Copyright &copy; 2018-2020 <a href="http://www.hxzygz.com">贵州华信智原</a>.</strong> 版权所有
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">最近活动</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-user bg-yellow"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>

                <p>New phone +1(800)555-1234</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-envelope-o bg-light-blue"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>

                <p>nora@example.com</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-file-code-o bg-green"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>

                <p>Execution time 5 seconds</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="label label-danger pull-right">70%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Update Resume
                <span class="label label-success pull-right">95%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-success" style="width: 95%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Laravel Integration
                <span class="label label-warning pull-right">50%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Back End Framework
                <span class="label label-primary pull-right">68%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Allow mail redirect
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Other sets of options are available
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Expose author name in posts
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Allow the user to show his name in blog posts
            </p>
          </div>
          <!-- /.form-group -->

          <h3 class="control-sidebar-heading">Chat Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Show me as online
              <input type="checkbox" class="pull-right" checked>
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Turn off notifications
              <input type="checkbox" class="pull-right">
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Delete chat history
              <a href="javascript:void(0)" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
            </label>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- jQuery 3 -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="bower_components/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.7 -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="bower_components/raphael/raphael.min.js"></script>
<script src="bower_components/morris.js/morris.min.js"></script>
<!-- Sparkline -->
<script src="bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="bower_components/jquery-knob/dist/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="bower_components/moment/min/moment.min.js"></script>
<script src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<!--<script src="dist/js/demo.js"></script>-->
<!-- page script -->
<script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="test/demo.js"></script>
<!--<script>
	//Date picker
    $('#datepicker').datepicker({
      autoclose: true
    })
</script>-->
<script>
  $(function () {
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
    })
    
    
    //选项框
  $("#chkAll").click(function(){
     if($("#chkAll").prop("checked")==true){
    	 
         $("input[name='chkBulletin']").each(function(){
             $(this).prop("checked",true);
         });
     }
     else{
         $("input[name='chkBulletin']").each(function(){
             $(this).prop("checked",false);
         });
     }
    });
    // 判断是否至少选择一项   
    $("#delete").click(function() {
       var checkedNum = $("input[name='chkBulletin']:checked").length; 
       if(checkedNum == 0) {   
            alert("请选择至少一项！");   
           return; 
       	}
       
       if(confirm("确定要删除所选项目？")) {   
           var checkedList = new Array();   
           $("input[name='chkBulletin']:checked").each(function() {   
               checkedList.push($(this).val());   
           });   
			
           /* $.ajax({   
               type: "POST",   
               url: "curr/deletemore.do",   
               data: {'delitems':checkedList.toString()}, 
               success: function(result) {   
                   $("[name ='chkBulletin']:checkbox").prop("checked", false); 
                   //刷新页面
                   //window.open("curr/initialize.do","-blank","");	
                  window.location.href="index.jsp";   
               }   
           }); 
           window.location.href="index.jsp";*/
           window.location.href="curr/deletemore.do?delitems="+checkedList.toString();   
       }
     });
    
    
    //修改数据
    $("#modification").click(function() {
        var checkedNum = $("input[name='chkBulletin']:checked").length; 
        if(checkedNum == 0) {   
            alert("请选择要修改的数据！");   
           return; 
       	}
           var checkedList = new Array();   
           $("input[name='chkBulletin']:checked").each(function() {   
               checkedList.push($(this).val());   
           });   
           window.location.href="curr/modification.do?modifiId="+checkedList.toString();   
      });
  });
</script>


</body>
</html>

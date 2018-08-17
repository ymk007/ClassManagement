<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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

</head>
<body>
 <form action="curr/select.do" method="post">
	<ul class="nav navbar-nav">
	<li style="margin:5px 10px;">
		<c:if test="${empty time}">
		<%String time = new SimpleDateFormat("YYYY-MM").format(new Date());%>
		<input type="text" class="jeinput" id="test02" placeholder="<%=time %>" name="time"/>
		</c:if>
		<c:if test="${!empty time}">
		<input type="text" class="jeinput" id="test02" placeholder="${time}" name="time"/>
		</c:if>
	</li>
	<li style="margin:5px 10px;"><button type="submit" class="btn btn-block btn-default"><span class="fa fa-search"></span>查询</button></li>
	<li style="margin:5px 10px;"><button type="button" class="btn btn-block btn-primary" id="modification"><span class="fa fa-pencil-square"></span> 修改</button></li>
	<li style="margin:5px 10px;"><button type="button" class="btn btn-block btn-primary" id="delete"><span class="fa fa-remove"></span> 删除</button></li>
	<%-- <c:if test="${empty download}">
	<li style="margin:5px 10px;"><button type="button" class="btn btn-block btn-primary" id="download"><span class="fa fa-cloud-download"></span> 下载</button></li>
	</c:if> --%>
	<c:if test="${!empty download}">
	<li style="margin:5px 10px;"><button type="button" class="btn btn-block btn-primary" id="download1"><span class="fa fa-cloud-download"></span> 下载一</button></li>
	
	<c:if test="${download=='2'||download=='3'}">
	<li style="margin:5px 10px;"><button type="button" class="btn btn-block btn-primary" id="download2"><span class="fa fa-cloud-download"></span> 下载二</button></li>
	</c:if>
	<c:if test="${download=='3'}">
	<li style="margin:5px 10px;"><button type="button" class="btn btn-block btn-primary" id="download3"><span class="fa fa-cloud-download"></span> 下载三</button></li>
	</c:if>
	</c:if>
</ul>
</form>
 <div class="row">
   <div class="col-xs-12">
     <div class="box">
     <c:if test="${empty user}">
     <div class="box-header" style="height: 600px;">
     	<h4 class="box-title">您还未登录，<a href="pages/examples/login.html" style="text-decoration:underline;">请点击登录！</a></h4>
     	</div>
     </c:if>	
     	
     	<c:if test="${!empty user}">
       <div class="box-header">
         <h3 class="box-title">课时列表</h3>
       </div>
       <% %>
       <!-- /.box-header -->
       <div class="box-body">
         <table id="example2" class="table table-bordered table-hover">
           <thead>
           <tr>
           	<th style="width: 2%;"><input type="checkbox" id="chkAll"></th>
             <th>日期</th>
             <th style="width: 10%;">星期</th>
             <th>起止日期</th>
             <th>班级</th>
             <th>授课地点</th>
             <th>课时内容</th>
             <th>课时折算</th>
           </tr>
           </thead>
           <tbody>
           <c:forEach items="${list_curr}" var="curr">
            <tr>
              <td><input type="checkbox" name="chkBulletin" value="${curr.id}"></td>
              <td><fmt:formatDate value="${curr.startDate}" type="both" pattern="MM月dd日"/></td>
              <td><fmt:formatDate value="${curr.startDate}" type="both" pattern="EEEE"/></td>
              <td><fmt:formatDate value="${curr.startDate}" type="both" pattern="HH时mm分SS秒"/>
              -<fmt:formatDate value="${curr.endDate}" type="both" pattern="HH时mm分SS秒"/></td>
              <td>${curr.grade}</td>
              <td>${curr.site}</td>
              <td>${curr.content}</td>
              <td>${curr.corrected}</td>
            </tr>
           </c:forEach>
         </table>
         
       </div>
       <!-- /.box-body -->
     </div>
     <!-- /.box -->
      </c:if>	
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
	/*$('#download').click(function () {
		  window.location.href="load/download.do";   
	}); */
	$('#download1').click(function () {
		  window.location.href="load/download.do?button=1";   
	});
	$('#download2').click(function () {
		  window.location.href="load/download.do?button=2";   
	});
	$('#download2').click(function () {
		  window.location.href="load/download.do?button=3";   
	});
	  
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : false,
      'autoWidth'   : false,
      'oLanguage'   :{oPaginate:{sFirst:"First",sLast:"Last",sNext:"下一页",sPrevious:"上一页"}}
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
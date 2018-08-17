<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>  
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>"> 
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>adds</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
  <!-- daterange picker -->
  <link rel="stylesheet" href="bower_components/bootstrap-daterangepicker/daterangepicker.css">
  <!-- bootstrap datepicker -->
  <link rel="stylesheet" href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
  <!-- iCheck for checkboxes and radio inputs -->
  <link rel="stylesheet" href="plugins/iCheck/all.css">
  <!-- Bootstrap Color Picker -->
  <link rel="stylesheet" href="bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
  <!-- Bootstrap time Picker -->
  <link rel="stylesheet" href="plugins/timepicker/bootstrap-timepicker.min.css">
  <!-- Select2 -->
  <link rel="stylesheet" href="bower_components/select2/dist/css/select2.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
  <link rel="stylesheet" href="js/jquery.datetimepicker.css">
  
  <link rel="stylesheet" type="text/css" href="./jquery.datetimepicker.css"/>

  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<c:if test="${add=='addLose'}">
	<div class="alert alert-warning">
		<a href="#" class="close" data-dismiss="alert">
			&times;
		</a>
		<strong id="err">添加失败！</strong>请核对你的信息是否有误。
	</div>
	</c:if>
	<c:if test="${add=='addSucc'}">
	<div id="myAlert" class="alert alert-success">
		<a href="#" class="close" data-dismiss="alert">&times;</a>
		<strong>添加成功,请返回查看新记录！</strong>
	</div>
	</c:if>
	<ul id="add" class="list-group" style="width: 350px; margin:3% auto;" >
	<form action="curr/addCourse.do" method="post">
	   <li class="list-group-item">
	   	<span>新增信息</span>
	   </li>
	   <li class="list-group-item">
	    <div class="input-group">
	      <div class="input-group-addon">
	        <i class="fa fa-calendar"></i>
	      </div>
	      <input type="text" id="datetimepicker2" class="form-control pull-right" name="startDate" placeholder="开始日期"/>
	    </div>
	   </li>
	   <li class="list-group-item">
		    <div class="input-group">
		      <div class="input-group-addon">
		        <i class="fa fa-calendar"></i>
		      </div>
		      <input type="text" id="datetimepicker00" class="form-control pull-right" name="endDate" placeholder="结束日期"/>
		    </div>
	   </li>
	   <li class="list-group-item">
	    <div class="input-group">
	      <div class="input-group-addon">
	        <i class="fa fa-group"></i>
	      </div>
	      <input type="text" class="form-control pull-right" name="grade" placeholder="班级">
	    </div>
	   </li>
	   
	   <li class="list-group-item">
	    <div class="input-group">
	      <div class="input-group-addon">
	        <i class="fa fa-institution"></i>
	      </div>
	      <input type="text" class="form-control pull-right" name="site" placeholder="授课地点">
	    </div>
	   </li>
	   <li class="list-group-item">
	    <div class="input-group">
	      <div class="input-group-addon">
	        <i class="fa fa-newspaper-o"></i>
	      </div>
	      <input type="text" class="form-control pull-right" name="content" placeholder="课程内容" >
	    </div>
	   </li>
	   <!-- <li class="list-group-item">
	    <div class="input-group ">
	    <label>课时折算:　　</label>
	      <select class="select2-search__field select2-search select2-search--inline" name="corrected" style="height: 30px;">
	      	<option value="1">1</option>
	      	<option value="2">2</option>
	      	<option value="3">3</option>
	      	<option value="4" selected="selected">4</option>
	      	<option value="5">5</option>
	      	<option value="6">6</option>
	      </select>
	      <input type="text" class="form-control pull-right" >
		    </div>
	    </li> -->
	    
	    <li class="list-group-item">
	    <div class="input-group">
	    <label>是否补课 :　</label>
	      <input type="button" name="zm" value="添加周末" data-toggle="modal" data-target="#modal-default">
	      　
	      <input type="button" name="wj" value="添加晚间">
	    </div>
	   </li>
	 <!--   周末补课信息选择 -->
		<div class="modal fade" id="modal-default">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">请选择周末补课天数</h4>
              </div>
              <div class="modal-body">
               <ul id="weekend" class="list-group">
					<!-- 显示周末时间 -->
			   </ul>
              </div>
              <div class="modal-footer">
              	<span class="pull-left">请选择时间段:　<input type="checkbox" name="zmsw"/>上午　<input type="checkbox" name="zmxw"/>下午</span>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="addzm">添加</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
	    
	    <li class="list-group-item" style="height: 55px;">
		    <div class="col-xs-5 pull-left" style="margin-left: 30px;">
		    <button type="submit" id="partsub" class="btn btn-warning btn-flat" style="width: 95px;">新增工作日</button>
		    </div>
		    <div class="col-xs-5 pull-right" >
		    <button type="button" id="return" class="btn btn-info btn-flat" style="width: 80px;">返回</button>
		    </div>
	    </li>
	    
	    </form>
	</ul>

<!-- jQuery 3 -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Select2 -->
<script src="bower_components/select2/dist/js/select2.full.min.js"></script>
<!-- InputMask -->
<script src="plugins/input-mask/jquery.inputmask.js"></script>
<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="bower_components/moment/min/moment.min.js"></script>
<script src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- bootstrap datepicker -->
<script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<!-- bootstrap color picker -->
<script src="bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!-- SlimScroll -->
<script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- iCheck 1.0.1 -->
<script src="plugins/iCheck/icheck.min.js"></script>
<!-- FastClick -->
<script src="bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- Page script -->
<script src="js/jquery.datetimepicker.js"></script>


<script src="build/jquery.datetimepicker.full.js"></script>

<script>
$(function () {
	
	$("input[name='endDate']").blur(function () {
		//var s = new Date($("input[name='startDate']").val().replace(-g,"//"));
		$("#datepd").remove();
		if($("input[name='startDate']").val()>$("input[name='endDate']").val()){
			$("#add").prepend("<div class='alert alert-warning' id='datepd' >开始日期不能大于结束日期<a href='#' class='close' data-dismiss='alert'>&times;</a></div>"); 
			//alert("开始日期不能大于结束日期！")
		}
	});
	
	$("#return").click(function() {
		window.location.href="curr/initialize.do"; 
	});
	//或取周末信息
	var zmdate = null;
	$("input[name='zm']").click(function(){
		//window.location.href="curr/initializeWeekend.do"; 
		var startDate = $("input[name='startDate']").val();
		var endDate = $("input[name='endDate']").val();
		var grade = $("input[name='grade']").val();
		var site = $("input[name='site']").val();
		var content = $("input[name='content']").val();
		//var url = "curr/initializeWeekend.do?startDate="+startDate+"&endDate="+endDate+"&grade="+grade+"&site="+site+"&content="+content;
		var url = "curr/initializeWeekend.do"
		$.ajax({
			type: "POST",     
		    dataType: "json",
            data : 
            	"startDate="+startDate+"&endDate="+endDate+"&grade="+grade+"&site="+site+"&content="+content
            ,
            url : url,
            error : function() {// 请求失败处理函数
            	alert("返回失败！");
            }, 
            success : function(data) {
            	zmdate = data;
                for(var i=0;i<data.length;i++){
            		$("#weekend").after("<li class='list-group-item'><input type='checkbox' name='selectzm' value='"+data[i]+"'/>"+data[i]+"</li>");
            	} 

            }
        });
		
		if($(this).prop("checked")==true){
			$(this).prop("id","#modal-default")
			$(this).prop("value","yes")
		}else{
			$(this).prop("data-target","yes")
		}
	});
	//添加周末
	$("#addzm").click(function() {
		var grade = $("input[name='grade']").val();
		var site = $("input[name='site']").val();
		var content = $("input[name='content']").val();
		var zmsw = $("input[name='zmsw']").val();
		var zmxw = $("input[name='zmxw']").val();
		var selectzm = [];
		
			$("input[name='selectzm']:checked").each(function () {
				selectzm.push($(this).val()); 
				
			});
		
			alert(selectzm);
		
		
		if(zmdate.length==0){
			return;
		}
		$.ajax({
			type: "POST",     
		    dataType: "json",
		    traditional: true,
            data :
            	"selectzm="+selectzm+"&zmsw="+zmsw+"&zmxw="+zmxw+"&grade="+grade+"&site="+site+"&content="+content 
            	//"selectzm":selectzm,
             ,
            url : "curr/addWeekend.do",
            error : function() {// 请求失败处理函数
            	alert("添加失败！");
            }, 
            success : function(data) {
				
            }
        });
		//window.location.href="curr/addWeekend.do"; 
	});
	/* $("input[name='zm']").hive(function(){
		if($(this).prop("checked")==true){
			$(this).prop("data-target","#modal-default")
		}else{
			$(this).prop("data-target","yes")
		}
	}); */
	
	$("input[name='zmsw']").click(function(){
		if($(this).prop("checked")==true){
			$(this).prop("value","yes")
		}
	});
	$("input[name='zmxw']").click(function(){
		if($(this).prop("checked")==true){
			$(this).prop("value","yes")
		}
	});
	$("input[name='wj']").click(function(){
		if($(this).prop("checked")==true){
			$(this).prop("value","yes")
		}
	});
});





$.datetimepicker.setLocale('ch');
$('#datetimepicker_format').datetimepicker({value:'2015/04/15 05:03', format: $("#datetimepicker_format_value").val()});
console.log($('#datetimepicker_format').datetimepicker('getValue'));

$("#datetimepicker_format_change").on("click", function(e){
	$("#datetimepicker_format").data('xdsoft_datetimepicker').setOptions({format: $("#datetimepicker_format_value").val()});
});
$("#datetimepicker_format_locale").on("change", function(e){
	$.datetimepicker.setLocale($(e.currentTarget).val());
});

$('#datetimepicker').datetimepicker({
dayOfWeekStart : 1,
lang:'en',
disabledDates:['1986/01/08','1986/01/09','1986/01/10'],
startDate:	'1986/01/05'
});
$('#datetimepicker').datetimepicker({value:'2015/04/15 05:03',step:10});

$('.some_class').datetimepicker({
			
		});

$('#default_datetimepicker').datetimepicker({
	formatTime:'H:i',
	formatDate:'d.m.Y',
	//defaultDate:'8.12.1986', // it's my birthday
	defaultDate:'+03.01.1970', // it's my birthday
	defaultTime:'10:00',
	timepickerScrollbar:false
});

$('#datetimepicker10').datetimepicker({
	step:5,
	inline:true
});
$('#datetimepicker_mask').datetimepicker({
	mask:'9999/19/39 29:59'
});

$('#datetimepicker1').datetimepicker({
	datepicker:false,
	format:'H:i',
	step:5
});
$('#datetimepicker2').datetimepicker({
	//yearOffset:222,
	lang:'ch',
	datepicker:true,
	timepicker:false,
	format:'Y/m/d',
	formatDate:'Y/m/d',
	//minDate:'-1970/01/02', // yesterday is minimum date
	//maxDate:'+1970/01/02' // and tommorow is maximum date calendar
});
$('#datetimepicker00').datetimepicker({
	//yearOffset:222,
	lang:'ch',
	datepicker:true,
	timepicker:false,
	format:'Y/m/d',
	formatDate:'Y/m/d',
	//minDate:'-1970/01/02', // yesterday is minimum date
	//maxDate:'+1970/01/02' // and tommorow is maximum date calendar
});
$('#datetimepicker3').datetimepicker({
	inline:true
});
$('#datetimepicker4').datetimepicker();
$('#open').click(function(){
	$('#datetimepicker4').datetimepicker('show');
});
$('#close').click(function(){
	$('#datetimepicker4').datetimepicker('hide');
});
$('#reset').click(function(){
	$('#datetimepicker4').datetimepicker('reset');
});
$('#datetimepicker5').datetimepicker({
	datepicker:false,
	allowTimes:['12:00','13:00','15:00','17:00','17:05','17:20','19:00','20:00'],
	step:5
});
$('#datetimepicker6').datetimepicker();
$('#destroy').click(function(){
	if( $('#datetimepicker6').data('xdsoft_datetimepicker') ){
		$('#datetimepicker6').datetimepicker('destroy');
		this.value = 'create';
	}else{
		$('#datetimepicker6').datetimepicker();
		this.value = 'destroy';
	}
});
var logic = function( currentDateTime ){
	if (currentDateTime && currentDateTime.getDay() == 6){
		this.setOptions({
			minTime:'11:00'
		});
	}else
		this.setOptions({
			minTime:'8:00'
		});
};
$('#datetimepicker7').datetimepicker({
	onChangeDateTime:logic,
	onShow:logic
});
$('#datetimepicker8').datetimepicker({
	onGenerate:function( ct ){
		$(this).find('.xdsoft_date')
			.toggleClass('xdsoft_disabled');
	},
	minDate:'-1970/01/2',
	maxDate:'+1970/01/2',
	timepicker:false
});
$('#datetimepicker9').datetimepicker({
	onGenerate:function( ct ){
		$(this).find('.xdsoft_date.xdsoft_weekend')
			.addClass('xdsoft_disabled');
	},
	weekends:['01.01.2014','02.01.2014','03.01.2014','04.01.2014','05.01.2014','06.01.2014'],
	timepicker:false
});
var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() + 2);
$('#datetimepicker11').datetimepicker({
	beforeShowDay: function(date) {
		if (date.getMonth() == dateToDisable.getMonth() && date.getDate() == dateToDisable.getDate()) {
			return [false, ""]
		}

		return [true, ""];
	}
});
$('#datetimepicker12').datetimepicker({
	beforeShowDay: function(date) {
		if (date.getMonth() == dateToDisable.getMonth() && date.getDate() == dateToDisable.getDate()) {
			return [true, "custom-date-style"];
		}

		return [true, ""];
	}
});
$('#datetimepicker_dark').datetimepicker({theme:'dark'})



  $(function () {
    //Datemask dd/mm/yyyy
    $('#datemask').inputmask('yyyy/mm/dd', { 'placeholder': 'yyyy/mm/dd' })
    //Datemask2 mm/dd/yyyy
    $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
    //Money Euro
    $('[data-mask]').inputmask()

    //Date range picker
    $('#reservation').daterangepicker()
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A' })
    //Date range as a button
    $('#daterange-btn').daterangepicker(
      {
        ranges   : {
          'Today'       : [moment(), moment()],
          'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month'  : [moment().startOf('month'), moment().endOf('month')],
          'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        startDate: moment().subtract(29, 'days'),
        endDate  : moment()
      },
      function (start, end) {
        $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
      }
    )

    //Date picker
    $('#datepicker').datepicker({
      autoclose: true
    })

    //iCheck for checkbox and radio inputs
    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
      checkboxClass: 'icheckbox_minimal-blue',
      radioClass   : 'iradio_minimal-blue'
    })
    //Red color scheme for iCheck
    $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
      checkboxClass: 'icheckbox_minimal-red',
      radioClass   : 'iradio_minimal-red'
    })
    //Flat red color scheme for iCheck
    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
      checkboxClass: 'icheckbox_flat-green',
      radioClass   : 'iradio_flat-green'
    })

    //Colorpicker
    $('.my-colorpicker1').colorpicker()
    //color picker with addon
    $('.my-colorpicker2').colorpicker()

    //Timepicker
    $('.timepicker').timepicker({
      showInputs: false
    })
  })
</script>

</body>
</html>
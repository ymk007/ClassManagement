package com.hx.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hx.pojo.Curriculum;
import com.hx.pojo.User;
import com.hx.util.WordUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
@Controller
@RequestMapping("load")
public class DownloadController {
	@RequestMapping("download")
	@ResponseBody
	public String download(@RequestParam("button") String button, HttpServletRequest request,HttpSession session,HttpServletResponse response){
		//获得数据
		List<Curriculum> list_curr=(List<Curriculum>) session.getAttribute("list_curr");
		User user= (User) session.getAttribute("user");
      //数据录入
      		String year = new SimpleDateFormat("YYYY").format(list_curr.get(0).getStartDate());
      		String yue = new SimpleDateFormat("MM").format(list_curr.get(0).getStartDate());
      		int total = 0;
      		 Map dataMap = new HashMap();
      		List list = new ArrayList();
      		//判短下载按钮
      		int i=0;
      		System.out.println(button);
      		if(button.equals("1")) {
      			System.out.println("下载1");
          		for (i = 0; i < 30; i++) {
          			if(list_curr.size()==i) {
          				break;
          			}
          			//调整时间格式
          			String day = new SimpleDateFormat("dd").format(list_curr.get(i).getStartDate());
          			String week = new SimpleDateFormat("EEEE").format(list_curr.get(i).getStartDate());
          			String time = new SimpleDateFormat("HH时mm分").format(list_curr.get(i).getStartDate())+"-"+
          					new SimpleDateFormat("HH时mm分").format(list_curr.get(i).getEndDate());
          			total += list_curr.get(i).getCorrected();
          			Map map = new HashMap();
          			map.put("num", i+1);
          			map.put("day", day);
          			map.put("week", week);
          			map.put("time", time);
          			map.put("grade", list_curr.get(i).getGrade());
          			map.put("site", list_curr.get(i).getSite());
          			map.put("content", list_curr.get(i).getContent());
          			map.put("name", user.getUserName());
          			map.put("corr", list_curr.get(i).getCorrected());
          			
          			list.add(map);
          		}
      		}
      		if(button.equals("2")) {
      			System.out.println("下载2");
          		for (i = 30; i < 60; i++) {
          			if(list_curr.size()==i) {
          				break;
          			}
          			//调整时间格式
          			String day = new SimpleDateFormat("dd").format(list_curr.get(i).getStartDate());
          			String week = new SimpleDateFormat("EEEE").format(list_curr.get(i).getStartDate());
          			String time = new SimpleDateFormat("HH时mm分").format(list_curr.get(i).getStartDate())+"-"+
          					new SimpleDateFormat("HH时mm分").format(list_curr.get(i).getEndDate());
          			total += list_curr.get(i).getCorrected();
          			Map map = new HashMap();
          			map.put("num", i+1);
          			map.put("day", day);
          			map.put("week", week);
          			map.put("time", time);
          			map.put("grade", list_curr.get(i).getGrade());
          			map.put("site", list_curr.get(i).getSite());
          			map.put("content", list_curr.get(i).getContent());
          			map.put("name", user.getUserName());
          			map.put("corr", list_curr.get(i).getCorrected());
          			
          			list.add(map);
          		}
      		}
      		if(button.equals("3")) {
      			System.out.println("下载3");
          		for (i = 60; i < list_curr.size(); i++) {
          			if(list_curr.size()==i) {
          				break;
          			}
          			//调整时间格式
          			String day = new SimpleDateFormat("dd").format(list_curr.get(i).getStartDate());
          			String week = new SimpleDateFormat("EEEE").format(list_curr.get(i).getStartDate());
          			String time = new SimpleDateFormat("HH时mm分").format(list_curr.get(i).getStartDate())+"-"+
          					new SimpleDateFormat("HH时mm分").format(list_curr.get(i).getEndDate());
          			total += list_curr.get(i).getCorrected();
          			Map map = new HashMap();
          			map.put("num", i+1);
          			map.put("day", day);
          			map.put("week", week);
          			map.put("time", time);
          			map.put("grade", list_curr.get(i).getGrade());
          			map.put("site", list_curr.get(i).getSite());
          			map.put("content", list_curr.get(i).getContent());
          			map.put("name", user.getUserName());
          			map.put("corr", list_curr.get(i).getCorrected());
          			
          			list.add(map);
          		}
      		}
      		
      		dataMap.put("list", list);
      		dataMap.put("year", year); 
      		dataMap.put("yue", yue);
      		dataMap.put("total", total);
      		dataMap.put("button", button);
        try {
			WordUtils.exportMillCertificateWord(request,response,dataMap);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "initialize.do";  
	}
 
	


}

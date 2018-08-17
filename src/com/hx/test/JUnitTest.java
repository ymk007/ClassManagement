package com.hx.test;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hx.util.MD5;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis-mvc-config.xml")
public class JUnitTest {
	@Autowired
	private MD5 md5;
	@Test
	public void test() {
		 	Date dateStr = new Date();
		 	dateStr = new Date(dateStr.getTime() + 1 * 3 * 60 * 60 * 1000);
		 	System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dateStr));
	        /*String dateStr2 = "2017-1-2 1:21:28";
	        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        try 
	        {
	            Date date2 = format.parse(dateStr2);
	            Date date = format.parse(dateStr);
	            int days = (int) ((date2.getTime() - date.getTime()) / (1000*3600*24));
	            System.out.println("�������ڵĲ�ࣺ" + days);
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }*/
	}
	
	private String differentDaysByMillisecond(Date date, Date date2) {
		// TODO Auto-generated method stub
		return null;
	}

	private String differentDays(Date date, Date date2) {
		// TODO Auto-generated method stub
		return null;
	}

	@Test
	public void insert() {
		String pwd = null;
		try {
			pwd = md5.md5Encode("123456");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(pwd);
	}
	@Test
	public void test2() throws IOException, TemplateException {
//		Users user=userService.getUser(1);
//		logger.info("��ѯ����Ϣ�ǣ�"+user);
//		System.out.println(user);
		 // Ҫ��������, ע��map��keyҪ��word��${xxx}��xxxһ��  
	      Map<String,Object> dataMap = new HashMap<String,Object>();  
	      dataMap.put("title", "����");  
/*	      List list = new ArrayList();
			for (int i = 0; i < 10; i++) {
				Map map = new HashMap();
				//map.put("number", i);
				map.put("title", "����"+i);
				list.add(map);
			}
			
			
			dataMap.put("list", list);
	            */
	    //Configuration���ڶ�ȡftl�ļ�  
	      Configuration configuration = new Configuration();  
	      configuration.setDefaultEncoding("utf-8");  
	        
	      /*����������ָ��ftl�ļ�����Ŀ¼·���ķ�ʽ, ע�������ַ�ʽ���� 
	       * ָ��ftl�ļ�����Ŀ¼��·��,������ftl�ļ���·�� 
	       */  
	      //ָ��·���ĵ�һ�ַ�ʽ(����ĳ��������·��ָ��)  
	      configuration.setClassForTemplateLoading(this.getClass(),"/template");  
	        
	      //ָ��·���ĵڶ��ַ�ʽ,�ҵ�·����C:/a.ftl  
	      //configuration.setDirectoryForTemplateLoading(new File("F:/"));  
	        
	        
	      // ����ĵ�·��������  
	     File outFile = new File("D:/test.doc");  
	       
	     //��utf-8�ı����ȡftl�ļ�  
	     Template t =  configuration.getTemplate("moban.ftl","utf-8");  
	     Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "utf-8"),10240);  
	        t.process(dataMap, out);  
	        out.close();  
		
		
	}

}

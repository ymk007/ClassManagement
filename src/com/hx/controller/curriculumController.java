package com.hx.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hx.pojo.Curriculum;
import com.hx.pojo.User;
import com.hx.service.CurriculumService;
import com.hx.service.UserService;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Controller
@RequestMapping("/curr")
public class curriculumController {
	@Autowired
	CurriculumService curriculumService;
	@Autowired
	private UserService userService;
	//��ʼ����ʱ��Ϣ
	@RequestMapping("initialize")
	public String initialize(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		String time = new SimpleDateFormat("YYYY-MM").format(new Date());
		request.setAttribute("time", time);
		time = time+"%";
		map.put("userId", user.getUserId());
		map.put("time", time);
		List<Curriculum> list_curr= curriculumService.selectByUserIdAndTime(map);
		//�ж����ذ�ť
			int num = (int) Math.ceil(list_curr.size()/30)+1;
			request.getSession().setAttribute("download",num);
		
		if(list_curr.size()==0) {
			request.getSession().removeAttribute("download");
		}
		request.getSession().setAttribute("list_curr", list_curr);
		return "showCourse.jsp";
	}
	//����ʱ���ѯ
	@RequestMapping("select")
	public ModelAndView select(@RequestParam("time") String time,HttpServletRequest request) {
		request.setAttribute("time", time);
		time = time+"%";
		ModelAndView mav = new ModelAndView();
		List<Curriculum> list_curr = curriculumService.selectByTime(time);
		//�ж����ذ�ť
			int num = (int) Math.ceil(list_curr.size()/30)+1;
			request.getSession().setAttribute("download",num);
		
		if(list_curr.size()==0) {
			request.getSession().removeAttribute("download");
		}
		System.out.println(list_curr.size());
		request.getSession().setAttribute("list_curr", list_curr);
		mav.setViewName("showCourse.jsp");
		return mav;
	}
	//ɾ���б�
	@Transactional
	@RequestMapping(value = "deletemore", method = RequestMethod.GET)
    public String deleteMore(HttpServletRequest request, HttpServletResponse response) {
        String items = request.getParameter("delitems");
        String[] item = items.split(",");
        for (int i = 0; i < item.length; i++) {
        	curriculumService.deleteByPrimaryKey(Short.parseShort(item[i]));
        }
        //User user = (User) request.getSession().getAttribute("user");
		//List<Curriculum> list_curr= userService.selectByUserId(user.getUserId());
		//request.getSession().setAttribute("list_curr", list_curr);
        return "curr/initialize.do";
    }
	//�޸�ҳ����ת
	@RequestMapping(value = "modification")
    public String modification(HttpServletRequest request, HttpServletResponse response) {
		String ids = request.getParameter("modifiId");
		request.getSession().setAttribute("ids", ids);
		String[] id = ids.split(",");
		List<Curriculum> modifi_curr= new ArrayList<Curriculum>();
		for (int i = 0; i < id.length; i++) {
			Curriculum curr = curriculumService.selectByPrimaryKey(Short.parseShort(id[i]));
			modifi_curr.add(curr);
        }
		request.getSession().setAttribute("modifi_curr", modifi_curr);
		request.setAttribute("modifi", "modification.jsp");
		return "modification.jsp";
		
	}
	//�޸�����
	@Transactional
	@RequestMapping(value = "doModifi")
    public String doModifi(HttpServletRequest request, HttpServletResponse response) {
		String modif_list = request.getParameter("modif_list");
		String[] curriculum_list = modif_list.split(",");
		
		List<Curriculum> curr= new ArrayList<Curriculum>();
		for (int i = 0; i < curriculum_list.length; i++) {
			Curriculum curriculum = new Curriculum();
			if((i+1)%6==0) {
				curriculum = new Curriculum();
			}
			curriculum.setId(Short.parseShort(curriculum_list[i]));
			curr.add(curriculum);
			
        }
		
		return "";
		
	}
	
	//�޸ĵ�������
	@Transactional
	@RequestMapping(value = "doModifi_part")
	public String doModifi_part(Short id,Short userId,String grade,Date startDate,Date endDate,String site,String content,Integer corrected,HttpServletRequest request, HttpServletResponse response) {
		Curriculum curriculum = new Curriculum();
		curriculum.setContent(content);
		curriculum.setCorrected(corrected);
		curriculum.setEndDate(endDate);
		curriculum.setGrade(grade);
		curriculum.setId(id);
		curriculum.setSite(site);
		curriculum.setStartDate(startDate);
		curriculum.setUserId(userId);
		int num = curriculumService.updateByPrimaryKeySelective(curriculum);
		if(num>0) {
			System.out.println("succ");
		}
		
		return "curr/update_modifi.do";
	}
	
	//�޸�ҳ��ˢ��
	@RequestMapping(value = "update_modifi")
    public String update_modifi(HttpSession session) {
		String ids = (String) session.getAttribute("ids");
		String[] id = ids.split(",");
		List<Curriculum> modifi_curr= new ArrayList<Curriculum>();
		for (int i = 0; i < id.length; i++) {
			Curriculum curr = curriculumService.selectByPrimaryKey(Short.parseShort(id[i]));
			modifi_curr.add(curr);
        }
		session.setAttribute("modifi_curr", modifi_curr);
		return "modification.jsp";
		
	}
	
	//���ҳ����ת
	@RequestMapping(value = "GotoAddCourse")
    public String GotoAddCourse(HttpServletRequest request) {
		request.setAttribute("modifi","addCourse.jsp");
		return "index.jsp";
	}
	
	//�������
	@Transactional
	@RequestMapping(value = "addCourse")
	public String addCourse(String grade,Date startDate,Date endDate,String site,String content,String zm,String wj,HttpSession session,HttpServletRequest request) {
        int days = (int) ((endDate.getTime() - startDate.getTime()) / (1000*3600*24))+1;
        
        System.out.println("�������ڵĲ�ࣺ" + days);
        
		
		User user = (User) session.getAttribute("user");
		short id = 0;
		int num=0;
		Date date=null;
		for(int i = 0;i < days;i++) {
			date = new Date(startDate.getTime() + i * 24 * 60 * 60 * 1000);
			//�Ƿ�ѡ������ĩ
			System.out.println(date);
			if(zm!=null) {
				if(!zm.equals("yes")) {
					//������ĩ
					if(new SimpleDateFormat("EEEE").format(date).equals("������")||
						new SimpleDateFormat("EEEE").format(date).equals("������")) {
						continue;
					}
				}
			}else {
				//������ĩ
				if(new SimpleDateFormat("EEEE").format(date).equals("������")||
					new SimpleDateFormat("EEEE").format(date).equals("������")) {
					continue;
				}
			}
			
			int cishu = 2;
			//�Ƿ���䲹��
			if(wj!=null) {
				if(wj.equals("yes")) {
					cishu = 3;
				}
			}
			
			for (int j = 0; j < cishu; j++) {
				int corrected = 0;
				Date start = null;
				Date end = null;
				//������Ͽ�ʱ
				if(j==0) {
					start = new Date(date.getTime() + 1 * 9 * 60 * 60 * 1000);
					end = new Date(date.getTime() + 1 * 12 * 60 * 60 * 1000);
					corrected = 3;
				}
				//��������ʱ
				if(j==1) {
					//����һ����ֻ��3��ʱ
					if(new SimpleDateFormat("EEEE").format(date).equals("����һ")) {
						start = new Date(date.getTime() + 1 * 14 * 60 * 60 * 1000);
						end = new Date(date.getTime() + 1 * 17 * 60 * 60 * 1000);
						corrected = 3;
					}else {
						start = new Date(date.getTime() + 1 * 14 * 60 * 60 * 1000);
						end = new Date(date.getTime() + 1 * 18 * 60 * 60 * 1000);
						corrected = 4;
					}
					
				}
				//�������ʱ
				if(j==2) {
					System.out.println("���");
					start = new Date(date.getTime() + 1 * 19 * 60 * 60 * 1000);
					end = new Date(date.getTime() + 1 * 21 * 60 * 60 * 1000);
					corrected = 2;
				}
				Curriculum curriculum = new Curriculum(id,user.getUserId(),grade,start,end,site,content,corrected);
				num = curriculumService.insertSelective(curriculum);
			}
			
        }
		if(num>0) {
			request.setAttribute("add", "addSucc");
		}else {
			request.setAttribute("add", "addLose");
		}
		/*int num = curriculumService.insertSelective(curriculum);
		if(num>0) {
			request.setAttribute("add", "addSucc");
		}else {
			request.setAttribute("add", "addLose");
		}*/
		//"curr/initialize.do"
		return "addCourse.jsp";
	}
	
	//��ʼ����ĩ
	@ResponseBody
	@RequestMapping(value = "initializeWeekend")
	public List<String> initializeWeekend(String grade,Date startDate,Date endDate,String site,String content,HttpSession session) {
		int days = (int) ((endDate.getTime() - startDate.getTime()) / (1000*3600*24))+1;
		 List<String> Weekends = new ArrayList<String>();
		 Date startDate01;
		 for(int i = 0;i < days;i++) {
			 startDate01 = new Date(startDate.getTime() + i * 24 * 60 * 60 * 1000);
			 if(new SimpleDateFormat("EEEE").format(startDate01).equals("������")||
				new SimpleDateFormat("EEEE").format(startDate01).equals("������")) {
				 String time = new SimpleDateFormat("YYYY��MM��dd�� EEEE").format(startDate01);
				 Weekends.add(time);
			 }
		 }
		return Weekends;
	}
	//�����ĩ����
	@ResponseBody
	@RequestMapping(value = "addWeekend")
	public String addWeekend(@RequestParam("selectzm")String[] selectzm,String grade,String zmsw,String zmxw,String site,String content,HttpSession session) {
		System.out.println("�����ĩ");
		User user = (User) session.getAttribute("user");
		Date stime = null;
		Date start = null;
		Date end = null;
		int corrected = 0;
		short id = 0;
		if(zmsw.equals("yes")) {
			for (int i = 0; i < selectzm.length; i++) {
				Date time=null;
				try {
					time = new SimpleDateFormat("YYYY��MM��dd�� EEEE").parse(selectzm[i]);
				} catch (ParseException e) {
					
					e.printStackTrace();
				}
				
				//start = new Date(stime.getTime() + 1 * 9 * 60 * 60 * 1000);
				//end = new Date(stime.getTime() + 1 * 12 * 60 * 60 * 1000);
			}
			//start = new Date(stime.getTime() + 1 * 9 * 60 * 60 * 1000);
			//end = new Date(stime.getTime() + 1 * 12 * 60 * 60 * 1000);
			corrected = 3;
			/*System.out.println("ʱ�����飺"+selectzm);*/
			/*for (int i = 0; i < zmdate.length; i++) {
				System.out.println("ʱ��"+zmdate[i]);
				stime = new SimpleDateFormat("YYYY��MM��dd�� HH:mm:ss").parse(zmdate.get(i));
				Curriculum curriculum = new Curriculum(id,user.getUserId(),grade,start,end,site,content,corrected);
				curriculumService.insertSelective(curriculum);
			}*/
		}
		/*if(zmxw.equals("yes")) {
			start = new Date(xtime.getTime() + 1 * 14 * 60 * 60 * 1000);
			end = new Date(xtime.getTime() + 1 * 18 * 60 * 60 * 1000);
			corrected = 4;
			for (int i = 0; i < zmdate.size(); i++) {
				Curriculum curriculum = new Curriculum(id,user.getUserId(),grade,start,end,site,content,corrected);
				curriculumService.insertSelective(curriculum);
			}
		}*/
		
		return "��ӳɹ���";
	}
	
	
	
	
	
	
	
	
	
	
	//����word�ĵ�(����)
	@RequestMapping(value = "download")
	public String download(String button ,HttpServletRequest request,HttpSession session){
		List<Curriculum> list_curr=(List<Curriculum>) session.getAttribute("list_curr");
		User user= (User) session.getAttribute("user");
		//����¼��
		String year = new SimpleDateFormat("YYYY").format(list_curr.get(0).getStartDate());
		String yue = new SimpleDateFormat("MM").format(list_curr.get(0).getStartDate());
		int total = 0;
		 Map dataMap = new HashMap();
		List list = new ArrayList();
		//�ж����ذ�ť
		int i=0;
		if(button.equals("2")) {
			i=19;
		}
		if(button.equals("3")) {
			i=37;
		}
		for (i = 0; i < list_curr.size(); i++) {
			//����ʱ���ʽ
			String day = new SimpleDateFormat("dd").format(list_curr.get(i).getStartDate());
			String week = new SimpleDateFormat("EEEE").format(list_curr.get(i).getStartDate());
			String time = new SimpleDateFormat("HHʱmm��").format(list_curr.get(i).getStartDate())+"-"+
					new SimpleDateFormat("HHʱmm��").format(list_curr.get(i).getEndDate());
			if(i>29) {
				break;
			}
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
		dataMap.put("list", list);
		dataMap.put("year", year); 
		dataMap.put("yue", yue);
		dataMap.put("total", total);
	      Configuration configuration = new Configuration();  
	      configuration.setDefaultEncoding("utf-8");  
	      configuration.setClassForTemplateLoading(this.getClass(),"/template");  
	     File outFile = new File("D:/"+user.getUserName()+"��"+button+"ҳ"+Math.random()*10000+".doc"); 
	     try {
	     Template t =  configuration.getTemplate("moban.ftl","utf-8");  
	     Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "utf-8"),10240);  
	        t.process(dataMap, out);  
				out.close();
			} catch (IOException | TemplateException e) {
				e.printStackTrace();
			}
		return "showCourse.jsp";  
	}
}

package com.hx.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hx.pojo.Curriculum;
import com.hx.pojo.User;
import com.hx.service.CurriculumService;
import com.hx.service.UserService;
import com.hx.util.MD5;


@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private CurriculumService curriculumService;
	@Autowired
	private MD5 md5;
	//异步检查验证码
	@RequestMapping(value="VerifyServlet")
	public String VerifyServlet(@RequestParam(value="verifyCode") String verifyCode,Model mod,
		HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charaset=utf-8");
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        PrintWriter out = null;
        try {
            //响应数据
            String resultData;
            //获取传过来的验证码
            if(verifyCode=="") {
                resultData = "N";
            }else {
                //获取kaptcha生成存放在session中的验证码
                String kaptchaValue = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
                //比较输入的验证码和实际生成的验证码是否相同
                if(kaptchaValue == null || kaptchaValue == ""||!verifyCode.equalsIgnoreCase(kaptchaValue)) {
                    resultData = "N";
                }else {
                    resultData = "Y";
                }
            }
            out = response.getWriter();
            out.write(resultData);
            out.flush();
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            if(out != null) {
                out.close();
            }
        }
	
		return "";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value="login")
	public String login(@RequestParam(value="userName") String userName,@RequestParam(value="userPwd") String userPwd,HttpSession session,HttpServletResponse response) {
		try {
			userPwd = md5.md5Encode(userPwd);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		Map<String, String> map  = new HashMap<String, String>();
		map.put("userName", userName);
		map.put("userPassword", userPwd);
		User user = userService.loginCheck(map);
		PrintWriter out = null;
		String date = null;
		//获取课时信息
		String time = new SimpleDateFormat("YYYY-MM").format(new Date());
		time = time+"%";
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("userId", user.getUserId());
		map1.put("time", time);
		List<Curriculum> list_curr= curriculumService.selectByUserIdAndTime(map1);
		
			int num = (int) Math.ceil(list_curr.size()/30)+1;
			session.setAttribute("download",num);
		
		if(user != null) {
			session.setAttribute("list_curr", list_curr);
			session.setAttribute("user", user);
			date="n";
		}
		 try {
			out = response.getWriter();
			out.write(date);
			 out.flush();
		} catch (IOException e) {
			
			e.printStackTrace();
		}finally {
            if(out != null) {
                out.close();
            }
        }
        
		return "login.html";
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "redirect:/login.html";
		
	}
	
	@RequestMapping(value="changePassword")
	public String changePassword(Short userId,String oldPwd,String newPwd,HttpSession session, HttpServletRequest rerquest) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", userId);
		map.put("oldPwd", oldPwd);
		map.put("newPwd", newPwd);
		int num = userService.changePassword(map);
		if(num>0) {
			rerquest.setAttribute("changeSucc", "修改成功！");
		}else {
			rerquest.setAttribute("changeErr", "修改失败，请确认你的密码是否一致！");
		}
		return "index.jsp";
		
	}
}

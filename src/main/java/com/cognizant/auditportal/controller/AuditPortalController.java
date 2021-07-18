package com.cognizant.auditportal.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cognizant.feignclients.AuditCheckListProxy;
import com.cognizant.feignclients.AuditSeverityProxy;
import com.cognizant.feignclients.AuthClient;
import com.cognizant.model.AuditDetails;
import com.cognizant.model.AuditRequest;
import com.cognizant.model.AuditResponse;
import com.cognizant.model.AuditType;
import com.cognizant.model.ProjectDetails;
import com.cognizant.model.ProjectManager;
import com.cognizant.model.Questions;
import com.cognizant.model.QuestionsEntity;
import com.cognizant.model.User;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class AuditPortalController {

	
	@Autowired
	AuthClient authClient;

	@Autowired
	AuditCheckListProxy auditCheckListProxy;
	
	@Autowired
	AuditRequest auditRequest;

	@Autowired
	AuditSeverityProxy auditSeverityProxy;
	
	@Autowired
	Environment env;
	
	
	@GetMapping("/loginPage")
	public String loginPage(@ModelAttribute User user){
		return "login";
	}
	
	@PostMapping(value="/home")
	public ModelAndView getHome(@Valid @ModelAttribute("user") User userCred, BindingResult result, HttpServletRequest request, ModelMap map) {
		
		log.info(env.getProperty("string.start"));
		
		log.info(userCred.toString());
		ResponseEntity<ProjectManager> data = null;
		ProjectManager projectManager = null;
		ModelAndView mv = new ModelAndView("login");
		map.addAttribute("auditType", new AuditType());
		map.addAttribute("projectDetails",new ProjectDetails());
		
		try {
			if (result.hasErrors()) {
				return mv;
			}
			data = (ResponseEntity<ProjectManager>) authClient.login(userCred);
			log.info(data.toString());
			projectManager = data.getBody();
			
			String authToken = projectManager.getAuthToken();
			log.info(authToken);
			
			request.getSession().setAttribute("token", "Bearer " + projectManager.getAuthToken());
			log.info(env.getProperty("string.end"));
			mv.setViewName("home");
			
		} catch (Exception e) {
			log.info(e.getMessage());
			map.addAttribute("msg", env.getProperty("string.invalid.cred"));
		}
		log.info(env.getProperty("string.end"));
		return mv;
		
	}
	
	
	@PostMapping("/AuditCheckListQuestions")
	public String getResponses(@ModelAttribute("projectDetails") ProjectDetails projectDetails,
			@ModelAttribute("auditType") AuditType auditType, RedirectAttributes redirectAttributes, HttpSession request,ModelMap map){
		
				log.info(env.getProperty("string.start"));
				
				List<QuestionsEntity> questions = new ArrayList<>();
				auditRequest.setProjectName(projectDetails.getProjectName());
				auditRequest.setProjectManagerName(projectDetails.getProjectManagerName());
				auditRequest.setApplicationOwnerName(projectDetails.getApplicationOwnerName());
				
				try {
					questions =  auditCheckListProxy.getCheckList(request.getAttribute("token").toString(), auditType).getBody();
					
				}catch(IndexOutOfBoundsException e) {
					log.info(e.getMessage());
					if (e.getMessage().contains(env.getProperty("string.null"))) {
						return "internalServerError";
					}
				}
				catch(Exception e) {
					
					log.info(e.getMessage());
					if(e.getMessage().contains(env.getProperty("string.token.exp")))
						return "forbidden";
				}
				
				for(QuestionsEntity question : questions) {
					if(question.getResponse()!=null) {
						question.setResponse(null);
					}
					
				}
				Questions questionslist = new Questions();
				questionslist.setQuestionsEntity(questions);
				redirectAttributes.addFlashAttribute("questions",questionslist);
				redirectAttributes.addFlashAttribute("auditType",auditType);
				
				log.info(env.getProperty("string.end"));
				return "redirect:/questions";
	}
	
	
	@GetMapping("/questions")
	public String getQuestions(@ModelAttribute("questions") Questions questions,
			@ModelAttribute("auditType") AuditType auditType,HttpSession session,ModelMap map) {
		
		log.info(env.getProperty("string.start"));
		ResponseEntity<?> authResponse=null;
		try {
			
				authResponse = authClient.getValidity(session.getAttribute("token").toString());
		}
		catch(Exception e) {
			if(e.getMessage().contains(env.getProperty("token.expired")))
				return "tokenExpiredPage";
			if(e.getMessage().contains(env.getProperty("auth.failed")))
				return "authFailed";
			
			return "redirect:/logout";
		}
		if(authResponse==null) {
			return "tokenExpiredPage";

		}
		log.info(env.getProperty("string.end"));
		return "questions";
		
	}
	
	@PostMapping("/questions")
	public String getResponses(@ModelAttribute("questions") Questions questions,HttpSession session ) {
		
		log.info(env.getProperty("string.start"));
		ResponseEntity<?> authResponse = null;
		List<QuestionsEntity> responseEntity=null;
		List<QuestionsEntity> questionsEntity = questions.getQuestionsEntity();
		
		try {
			authResponse = authClient.getValidity(session.getAttribute("token").toString());
			responseEntity = auditCheckListProxy.saveResponses(session.getAttribute("token").toString(), questionsEntity).getBody();

		}
		catch(Exception e) {
			if(e.getMessage().contains(env.getProperty("token.expired")))
				return "tokenExpiredPage";
			if(e.getMessage().contains(env.getProperty("auth.failed")))
				return "authFailed";
			
			return "redirect:/logout";
		}
		if(authResponse==null || responseEntity==null) {
			return "tokenExpiredPage";

		}
		AuditDetails auditDetails = new AuditDetails(questions.getQuestionsEntity().get(0).getAuditType(), new Date());
		auditRequest.setAuditDetails(auditDetails);
		log.info(env.getProperty("string.end"));
		return "redirect:/status";
	}
	
	@GetMapping("/status")
	public String getProjectExecutionStatus(HttpSession request,ModelMap map) {
		
		log.info(env.getProperty("string.start"));
		AuditResponse auditResponse = null;
		log.info(auditRequest.toString());
		try {
			auditResponse = auditSeverityProxy.auditSeverity(request.getAttribute("token").toString(),auditRequest).getBody();
			 
		}
		catch(Exception e) {
			log.info(e.getMessage());
			if(e.getMessage().contains(env.getProperty("string.token.exp")))
				return "tokenExpiredPage";

			return "tokenExpiredPage";
		}
		map.addAttribute("auditResponse",auditResponse);
		log.info(env.getProperty("string.end"));
		return "status";
		
	}
	
	@GetMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/loginPage";
	}

	
}

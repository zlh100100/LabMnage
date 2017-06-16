package com.bysj.cqjtu.teacher.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bysj.cqjtu.log.annotation.SystemControllerLog;
import com.bysj.cqjtu.manager.constance.OperateStatu;
import com.bysj.cqjtu.manager.domain.Sy02;
import com.bysj.cqjtu.manager.domain.Sy04;
import com.bysj.cqjtu.manager.domain.Sy05;
import com.bysj.cqjtu.manager.domain.Sy08Exp;
import com.bysj.cqjtu.manager.domain.Sy12;
import com.bysj.cqjtu.manager.pojo.UserMessage;
import com.bysj.cqjtu.student.domain.Sy06;
import com.bysj.cqjtu.student.domain.Sy07;
import com.bysj.cqjtu.student.domain.Sy08;
import com.bysj.cqjtu.student.domain.Sy09;
import com.bysj.cqjtu.student.domain.Sy13;
import com.bysj.cqjtu.teacher.constant.TeacherConstance;
import com.bysj.cqjtu.teacher.dto.LabManager;
import com.bysj.cqjtu.teacher.service.DownLoadResourceService;
import com.bysj.cqjtu.teacher.service.ExperimentService;
import com.bysj.cqjtu.teacher.service.LabApplyService;
import com.bysj.cqjtu.teacher.service.StudentManageService;
import com.bysj.cqjtu.teacher.service.TeacherService;
import com.bysj.cqjtu.util.PageEntity;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
	
	@Autowired
	private TeacherService teacherService;
	@Autowired
	private LabApplyService lab;
	@Autowired
	private ExperimentService expService;
	@Autowired
	private StudentManageService studentManageService;
	@Autowired
	private DownLoadResourceService downLoadResourceService;
	
	@RequestMapping("/query")
	@ResponseBody
	@SystemControllerLog(description ="查询教师列表")
	public List<Sy05> queryMsg (Model model) throws Exception {
		List<Sy05> list = teacherService.getTeacherList();
		model.addAttribute("list", list);
		return list;
	}

	
	/**
	 * 查询实验室相关信息
	 * @param session
	 * @param pageNum
	 * @param pageSize
	 * @param csy125
	 * @return
	 */
	@RequestMapping("/queryLab")
	@ResponseBody
	@SystemControllerLog(description ="查询实验室相关信息")
	public PageEntity<Map> queryList(HttpSession session,Integer pageNum, Integer pageSize,Integer csy125){
	    UserMessage userMessage = (UserMessage) session.getAttribute("user");
	    Sy02 sy02 =userMessage.getSy02();
	    return lab.queryLabList(pageNum,pageSize,csy125,sy02);

	}
	/**
	 * 查询实验室数量
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryLabCount")
    @ResponseBody
    @SystemControllerLog(description ="查询实验室数量")
	public Map queryLabCount(HttpSession session,Integer csy125) throws Exception{
	    UserMessage userMessage = (UserMessage) session.getAttribute("user");
        Sy02 sy02 =userMessage.getSy02();
	    return lab.queryLabCount(csy125,sy02);
	} 
	/**
	 * 通过id查询实验室相关信息
	 * @param request
	 * @return
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	@SystemControllerLog(description ="通过id查询实验室相关信息")
	public Map queryByid(HttpServletRequest request){
		//Sy11 labMsg = new Sy11();
	    Map map= new HashMap();
		String idStr = request.getParameter("id");
		map=lab.queryLabById(Integer.parseInt(idStr));
		return map;
	}
	
	/**
	 * 申请实验室后更新数据
	 * @param request
	 * @param session
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/addLabArrange")
	@ResponseBody
	@SystemControllerLog(description ="申请实验室")
	public Map addLabArrange(@RequestBody Sy12 sy12,HttpSession session) {
		UserMessage userMassage = (UserMessage)session.getAttribute("user");
		int userId =userMassage.getSy02().getCsy020();
		sy12.setCsy020(String.valueOf(userId));
		try {
            return lab.addLabArrange(sy12);
        } catch (Exception e) {
            Map map= new HashMap();
            map.put("statu", OperateStatu.INSERT_SY12_FAIL);
            return map;
        }
	}
	/**
	 * 查询出实验安排
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryExp")
	@ResponseBody
	@SystemControllerLog(description ="查询出实验安排")
	public List<Sy08Exp> queryExperiment(HttpSession session){
	    UserMessage userMessage = (UserMessage) session.getAttribute("user");
		List<Sy08Exp> list = new ArrayList<>();
		System.out.println("教师id"+userMessage.getSy05().getCsy050());
		list = expService.queryExp(userMessage.getSy05().getCsy050());
		return list;
	}
	
	@RequestMapping("/queryExpName")
	@ResponseBody
	@SystemControllerLog(description ="查询出实验安排")
	public List<String> queryExpName(HttpSession session){
	    UserMessage userMessage = (UserMessage) session.getAttribute("user");
	    List<String> result = new ArrayList<>();
		List<Sy08Exp> list = new ArrayList<>();
		list = expService.queryExp(userMessage.getSy05().getCsy050());
		for(Sy08Exp s : list){
			result.add(s.getCsy061());
		}
		//去重
		HashSet<String> hash = new HashSet<>(result);
		result.clear();
		result.addAll(hash);
		for(String name:result){
			System.out.println("课程名"+name);
		}
		return result;
	}
	
	
	/**
	 * 删除实验安排
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/deleteExp")
	@ResponseBody
	public Map deleteExp(HttpServletRequest request,HttpServletResponse response){
		Map<String,String> map = new HashMap<>();
		try{
			String items = request.getParameter("delitems");
			String []item = items.split(",");
			for(int i=0;i<item.length;i++){
				System.out.println(item[i]);
			}
			int num = expService.deleteExp(item);
			if(num>0){
				map.put("status", "删除成功");
				
			}else{
				map.put("status", "删除实验失败");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
		
	}
	/**
	 * 添加实验安排
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/addExp")
	@ResponseBody
	public Map addExp(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		Map<String,String> map = new HashMap<>();
		try{
		    UserMessage userMassage = (UserMessage)session.getAttribute("user");
	        int userId =userMassage.getSy02().getCsy020();
	        System.out.println("userId"+userId);
	        Sy05 teacher = teacherService.queryTeacher(userId);
	        //教师id
	        int csy050 = teacher.getCsy050();
			String items = request.getParameter("additems");
			String []item = items.split(",");
			Sy06 classResult = expService.queryClassByName(item[0]);
			//课程id
			int csy060 = classResult.getCsy060();
			Sy08 exp = new Sy08();
			exp.setCsy050(String.valueOf(csy050));
			exp.setCsy060(String.valueOf(csy060));
			exp.setCsy081(item[1]);
			exp.setCsy082(item[4]);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			exp.setCsy083(format.parse(item[2]));
			exp.setCsy084(format.parse(item[3]));
			exp.setCsy085((byte)0);
			int num=expService.addExp(exp);
			if(num>0){
				map.put("status", "添加成功");
			}else{
				map.put("status", "添加实验安排失败");
			}
			
			for(int i=0;i<item.length;i++){
				System.out.println(item[i]);
			}
			return map;
		}catch(Exception e){
			e.printStackTrace();
			return map;
		}
		
	}
	
	/**
	 * 搜索课程，模糊查询
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/searchExp")
	@ResponseBody
	public Map searchExp(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		Map<String,List> map = new HashMap<>();
	    UserMessage userMessage = (UserMessage) session.getAttribute("user");
		int id = userMessage.getSy05().getCsy050();
		List<Sy08Exp> resultList = new ArrayList<>();
		String items = request.getParameter("searchitems");
		List<Sy08Exp> list = expService.searchExp(items);
		System.out.println(id);
		if(list.size()!=0){
			for(Sy08Exp s :list ){
				if(s.getCsy050().equals(String.valueOf(id))){
					resultList.add(s);
				}
				System.out.println("结果"+s.getCsy050()+"  "+s.getCsy061());
			}
			map.put("result", resultList);
		}else{
			List<String> errorList = new ArrayList<>();
			errorList.add("没有任何该课程信息");
			map.put("error", errorList);
		}
		return map;
	}
	
	@RequestMapping("/queryEdit")
	@ResponseBody
	@SystemControllerLog(description ="查询详细信息")
	public LabManager queryEdit(HttpServletRequest request, HttpSession session) throws Exception{
		UserMessage userMassage = (UserMessage)session.getAttribute("user");
		LabManager labManager = new LabManager();
		String id  = request.getParameter("id");
		int userId =userMassage.getSy02().getCsy020();
//		System.out.println(userId);
		int i = Integer.parseInt(id);
		labManager = lab.queryEdit(i,userId);
		if(labManager.getSy12().getCsy125()==null){
			labManager.getSy12().setCsy125(Byte.parseByte("0"));
		}
		return labManager;
		
	}
	
	/**
	 * 查询出学生完成的实验报告情况
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryReport")
	@ResponseBody
	public Map queryReport(HttpSession session){
		Map<String,List> map = new HashMap<>();
		//查询实验报告
		map = expService.queryReport();
		return map;
	}
	
	@RequestMapping("/queryClassScore")
	@ResponseBody
	public Map queryClassScore(){
		Map<String,List> map = new HashMap<>();
		//查询课程成绩
		map = expService.queryClass();
		return map;
	}
	

	@RequestMapping("/studentExp")
	@ResponseBody
	public void studentExp(Model model,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		List<Sy08Exp> list = new ArrayList<>();
		RequestDispatcher rd = request.getRequestDispatcher("/ExpStudent.jsp");  
        rd.forward(request, response);  
	}
	
	/**
	 * 教师查看实验详情，可查看学生完成实验的情况并进行评分；
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryStudentExp")
	@ResponseBody
	public List<Sy08Exp> queryStudentExp(HttpSession session){
	    UserMessage userMessage = (UserMessage) session.getAttribute("user");
		List<Sy08Exp> list = new ArrayList<>();
		list = expService.queryExp(userMessage.getSy05().getCsy050());
		session.setAttribute("list", list);
		return list;
	}	
	
	/**
	 * 给学生实验报告评分
	 */
	@RequestMapping("/queryStudentReport")
	@ResponseBody
	@SystemControllerLog(description ="给学生实验报告评分")
	public Map queryStudentReport(HttpServletRequest request){
		Map<String,Object> map = new HashMap<>();
		String id = request.getParameter("id");
		//提交的实验
		Sy09 result = expService.queryBykey(Integer.parseInt(id));
		Sy04 student = expService.queryStudent(result.getCsy040());
		map.put("Sy09", result);
		map.put("Sy04", student);
		return map;
		
	}
	
	/**
	 * 查询特定的学生
	 */
	@RequestMapping("/queryStudentReportByid")
	@ResponseBody
	@SystemControllerLog(description ="查询特定的学生")
	public Map queryStudentReportByid(HttpServletRequest request){
		Map<String,Object> map = new HashMap<>();
		String id = request.getParameter("id");
		map = expService.queryReportByid(Integer.parseInt(id));
		return map;
		
	}

	/**
	 * 修改实验分数
	 * @param sy09
	 * @param request
	 */
	@RequestMapping("/updateStudentReport")
	@ResponseBody
	@SystemControllerLog(description ="更新学生实验报告")
	public Map updateStudentReport(@RequestBody Sy09 sy09, HttpServletRequest request){
		Map<String,String> map = new HashMap<>();
		//修改实验分数
		int i = expService.updateReposrt(sy09);
		if(i==0){
			map.put("Status", "评分失败");
		}if(i!=0){
			map.put("Status", "评分成功");
		}
		return map;
		
	}
	
	/**
	 * 给学生实验课程评分
	 */
	@RequestMapping("/queryStudentClass")
	@ResponseBody
	@SystemControllerLog(description ="给学生实验课程评分")
	public Map queryStudentClass(HttpServletRequest request){
		Map<String,Object> map = new HashMap<>();
		String items = request.getParameter("additems");
		String []item = items.split(",");
		Sy07 record = new Sy07();
		record.setCsy040(item[0]);
		record.setCsy060(item[1]);
		map = expService.queryStudentClass(record);
		return map;
		
	}
	
	/**
	 * 修改课程分数
	 * @param sy09
	 * @param request
	 */
	@RequestMapping("/updateStudentClass")
	@ResponseBody
	@SystemControllerLog(description ="更新学生课程")
	public Map updateStudentClass(HttpServletRequest request){
		Map<String,String> map = new HashMap<>();
		String items = request.getParameter("items");
		String []item = items.split(",");
		Sy07 score = new Sy07();
		score.setCsy040(item[0]);
		score.setCsy060(item[1]);
		score.setCsy071(Integer.parseInt(item[2]));
		int i = expService.insert(score);
		if(i==0){
			map.put("Status", "评分失败");
		}if(i!=0){
			map.put("Status", "评分成功");
		}
		return map;
		
	}
	
	/**
	 * 验证申请
	 * @param sy12
	 * @param session
	 * @return
	 */
	@RequestMapping("/validateArrage")
    @ResponseBody
    @SystemControllerLog(description="验证申请")
	public Map validateArrage(@RequestBody Sy12 sy12,HttpSession session) throws Exception{
	    UserMessage userMassage = (UserMessage)session.getAttribute("user");
        int userId =userMassage.getSy02().getCsy020();
        sy12.setCsy020(String.valueOf(userId));
        return lab.validateArrage(sy12);
	}
	/**
	 * 获取所有实验课程
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryCourse")
    @ResponseBody
    @SystemControllerLog(description="获取所有实验课程")
	public List<Map> queryCourse(HttpSession session) throws Exception{
	    UserMessage userMassage = (UserMessage)session.getAttribute("user");
        int csy050 =userMassage.getSy05().getCsy050();
        Sy05 sy05 = new Sy05();
        sy05.setCsy050(csy050);
        return studentManageService.queryCourse(sy05);
	}
	/**
	 * 获取所有的学院
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryCollege")
    @ResponseBody
    @SystemControllerLog(description="获取所有的学院")
	public List<Map> queryCollege() throws Exception{
	    return studentManageService.queryCollege();
	}
	/**
	 * 获取学院下对应的班级
	 * @param aaa105
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryClass")
    @ResponseBody
    @SystemControllerLog(description="获取学院下对应的班级")
	public List<Map> queryClass(String aaa105) throws Exception{
	    return studentManageService.queryClass(aaa105);
	}
	/**
	 * 安装班级获取学生列表
	 * @param csy043
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryStudentList")
    @ResponseBody
    @SystemControllerLog(description="安装班级获取学生列表")
	public List<Sy04> queryStudentList(String csy043) throws Exception{
	    return studentManageService.queryStudentList(csy043);
	}
	/**
	 * 按照实验课程查询学生列表
	 * @param csy060
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryStudentListByCourse")
    @ResponseBody
    @SystemControllerLog(description="按照实验课程查询学生列表")
	public List<Sy04> queryStudentListByCourse(String csy060) throws Exception{
	    return studentManageService.queryStudentListByCourse(csy060);
	}
	/**
	 * 删除该课程的学生
	 * @param sy07
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteStudent")
    @ResponseBody
    @SystemControllerLog(description="删除该课程的学生")
	public Map deleteStudent(@RequestBody Sy07 sy07){
	    try {
            return studentManageService.deleteStudent(sy07);
        } catch (Exception e) {
            Map map = new HashMap();
            map.put("statu", TeacherConstance.DELETE_STUDENT_INCOURCE_FAIL);
            return map;
        }
	}
	/**
	 * 添加学生到课程
	 * @param ids
	 * @param csy060
	 * @return
	 */
	@RequestMapping("/addStudentToCourse")
    @ResponseBody
    @SystemControllerLog(description="添加学生到课程")
	public Map addStudentToCourse(String ids,String csy060){
	    try {
            return studentManageService.addStudentToCourse(ids,csy060);
        } catch (Exception e) {
            Map map = new HashMap();
            map.put("statu", TeacherConstance.ADD_STUDENT_INCOURCE_FAIL);
            return map;
        }
	}
	/**
	 * 验证是否已经有该学生
	 * @param ids
	 * @param csy060
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/validateStudentInCource")
    @ResponseBody
    @SystemControllerLog(description="验证是否已经有该学生")
	public Map validateStudentInCource(String ids,String csy060) throws Exception{
	    return studentManageService.validateStudentInCource(ids,csy060);
	}
	/**
     * 批量删除课程下的学生
     * @param ids
     * @param csy060
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteStudentInCourseBatch")
    @ResponseBody
    @SystemControllerLog(description="验证是否已经有该学生")
	public Map deleteStudentInCourseBatch(String ids,String csy060){
	    try {
            return studentManageService.deleteStudentInCourseBatch(ids,csy060);
        } catch (Exception e) {
            Map map = new HashMap();
            map.put("statu", TeacherConstance.DELETE_STUDENT_INCOURCE_FAIL);
            return map;
        }
	}
    
    @RequestMapping("/resourceShow")
    @ResponseBody
	public Map<String,List>  show(){
    	Map<String,List> map = new HashMap<>();
    	map = downLoadResourceService.queryResource();
        return map;
   
	}
    
    @RequestMapping(value="/resourceUp", produces="text/plain; charset=utf-8")
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile multipartFile,HttpSession session) {
        try {
        	//创建资源表对象
        	Sy13 record = new Sy13();
        	UserMessage userMassage = (UserMessage)session.getAttribute("user");
    		int userId =userMassage.getSy02().getCsy020();
    		String userName = userMassage.getSy02().getCsy021();
    		System.out.println("userid="+userId+"  userName="+userName);
            // ... 文件目录可做进一步处理,避免多个重名文件覆盖
            String dirPath = "D:/";
            // 1.获取上传的文件名称和内容
            String filename = multipartFile.getOriginalFilename();
            System.out.println("文件大小："+multipartFile.getSize());
            String size = "";
            if((multipartFile.getSize()/1024)>1000){
            	size = ((multipartFile.getSize()/1024)/1024)+"."+ ((multipartFile.getSize()/1024)%1024) + "M";
            }else{
            	size = (multipartFile.getSize()/1024)+"."+ (multipartFile.getSize()%1024) + "KB";
            }
            System.out.println(size);
            String address = dirPath+"/"+filename;
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String date = format.format(new Date());
            String file = filename.substring(0,filename.lastIndexOf("."));
            System.out.println("文件名:"+file);
            record.setCsy020(userId);
            record.setCsy131(file);
            record.setCsy133(filename);
            record.setCsy134(address);
            try {
				record.setCsy136(format.parse(date));
			} catch (ParseException e) {
				e.printStackTrace();
			}
            record.setCsy160(1);
            record.setCsy135((byte)0);
            record.setCsy137("1");
            record.setCsy138(size);
            byte[] data = multipartFile.getBytes();
            // 2.将文件写入到本地，根据文件名命名
            FileUtils.writeByteArrayToFile(new File(dirPath, filename), data);
            // Log,显示文件全路径
            System.out.println("成功上传文件: " + filename);
            downLoadResourceService.insert(record);
            return "文件上传成功";
        } catch (IOException e) {
        	System.out.println("上传文件失败,发生了错误: " + e.getMessage());
            return "文件上传失败";
        }
    }
    
    @RequestMapping("/resourceDown")
    public ResponseEntity<byte[]> download(String filepath) {
        try {
        	byte[] file = filepath.getBytes("ISO-8859-1");
        	filepath = new String(file, "UTF-8");
        	System.out.println("文件名为："+filepath);
            if (null != filepath && !"".equals(filepath.trim())) {
                // ... 文件目录可做进一步处理,避免文件重名时获取不到正确的目标文件
                // 1.获取文件名,读取本地磁盘
                byte[] data = FileUtils.readFileToByteArray(new File(filepath));
                // 2.设置响应头,并返回响应数据
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                headers.setContentDispositionFormData("attachment", filepath);
                return new ResponseEntity<byte[]>(data, headers, HttpStatus.CREATED);
            }
        } catch (IOException e) {
            System.out.println("下载文件失败,发生了错误: " + e.getMessage());
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
    
	/**
	 * 搜索资源
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/searchResource")
	@ResponseBody
	public Map searchResource(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		Map<String,List> map = new HashMap<>();
	    UserMessage userMessage = (UserMessage) session.getAttribute("user");
	    //用户id
		int id = userMessage.getSy05().getCsy050();
		String items = request.getParameter("searchitems");
		System.out.println(id);
    	map = downLoadResourceService.searchResource(items);
		if(map.get("Sy13").size()!=0){
			return map;
		}else{
			List<String> errorList = new ArrayList<>();
			errorList.add("没有任何该资源");
			map.put("error", errorList);
			return map;
		}
		
	}
}

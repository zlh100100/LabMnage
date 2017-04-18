

package com.bysj.cqjtu.manager.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bysj.cqjtu.log.annotation.SystemControllerLog;
import com.bysj.cqjtu.manager.constance.OperateStatu;
import com.bysj.cqjtu.manager.domain.Sy02;
import com.bysj.cqjtu.manager.domain.Sy03;
import com.bysj.cqjtu.manager.domain.Sy04;
import com.bysj.cqjtu.manager.domain.Sy05;
import com.bysj.cqjtu.manager.pojo.UserMessage;
import com.bysj.cqjtu.manager.service.UserManagerService;
import com.bysj.cqjtu.util.ExceltoList;
import com.bysj.cqjtu.util.PageEntity;

/**
 * 管理员用户管理
 * @author fuzhengjun
 *2017年3月22日下午5:00:43
 *
 */
@RequestMapping("/userManager")  
@Controller 
public class UserManagerController {
    @Autowired
    private UserManagerService userManagerService;
    
    /**
     * 获取所有用户信息
     * @return
     * @throws Exception
     */
    @RequestMapping("/getAllUser")
    @ResponseBody
    @SystemControllerLog(description = "获取用户信息") 
    public PageEntity<Map> getAllUser(Integer pageNum, Integer pageSize)throws Exception{
        return userManagerService.queryAllUser(pageNum,pageSize);
    }
    /**
     * 删除用户信息
     * @param csy020
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteUser") 
    @ResponseBody 
    public Map deleteUser(int csy020)throws Exception{
       boolean deleteFlag=userManagerService.deleteUser(csy020);
       Map map=new HashMap();
       if(deleteFlag==true){
           map.put("statu", OperateStatu.DELETE_SUCCESS);
       }else{
           map.put("statu", OperateStatu.DELETE_FAIL);
       }
       return map;
    }
    /**
     * 批量删除用户信息
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteUserBatch")
    @ResponseBody
    public Map deleteUserBatch(String ids) throws Exception{
        String []arr=ids.split(",");
        boolean deleteFlag;
        int j=0;
        for(int i=0;i<arr.length;i++){
            deleteFlag=userManagerService.deleteUser(Integer.parseInt(arr[i]));
            if(deleteFlag==true){
                j++;
            }
        }
        Map map=new HashMap();
        if(j==arr.length){           
            map.put("statu", OperateStatu.DELETE_SUCCESS);
        }else {
            map.put("statu", OperateStatu.DELETE_FAIL);
        }
        return map;
    }
    /**
     * 按条件查询用户
     * @param sy02
     * @return
     * @throws Exception
     */
    @RequestMapping("/queryMenuByCondition")
    @ResponseBody
    public List<Sy02> queryMenuByCondition(@RequestBody Sy02 sy02) throws Exception{
        List<Sy02> list=userManagerService.queryMenuByCondition(sy02);
        return list;
    }
    /**
     * 添加用户
     * @param sy02
     * @return
     * @throws Exception
     */
    @RequestMapping("/addUser")
    @ResponseBody
    public Map addUser(@RequestBody UserMessage userMessage) throws Exception{
        Map map=userManagerService.addUser(userMessage);
        return map;
    }
    /**
     * 读取文件
     * @param filename
     * @return
     * @throws Exception
     */
    @RequestMapping("/readExcel")
    @ResponseBody
    public List readExcel(@RequestParam MultipartFile[] btnFile, HttpServletRequest request, HttpServletResponse response,Integer csy010)throws Exception{
        //文件类型:btnFile[0].getContentType()  
        //文件名称:btnFile[0].getName()
        List sy02List=new ArrayList();
        if(btnFile[0].getSize()>Integer.MAX_VALUE){//文件长度  
            sy02List.add("error");  
        }else{
            InputStream is = btnFile[0].getInputStream();//多文件也适用,我这里就一个文件  
            byte[] b = new byte[(int)btnFile[0].getSize()];  
            int read = 0;  
            int i = 0;  
            while((read=is.read())!=-1){  
                b[i] = (byte) read;  
                i++;  
            }  
            is.close(); 
            String newfilename="D://"+btnFile[0].getOriginalFilename();
            OutputStream os = new FileOutputStream(new File(newfilename));
            os.write(b);  
            os.flush();  
            os.close();
            //上传完毕
            //数据处理
            //读取到list
            List<Integer> rowAndCol=ExceltoList.getExcelRowsAndCols(newfilename);
            if(csy010==OperateStatu.TYPE_STUDENT&&rowAndCol.get(1)==7){
                List<List> list=ExceltoList.excel2List(newfilename); 
               
                for (List rowList : list) {  
                    UserMessage userMessage=new UserMessage();
                    Sy02 sy02=new Sy02();
                    Sy04 sy04=new Sy04();
                    sy02.setCsy010(Byte.parseByte(rowList.get(0).toString()));
                    sy02.setCsy021((String)rowList.get(1));
                    sy02.setCsy022((String)rowList.get(2));
                    sy04.setCsy040((String)rowList.get(3));
                    sy04.setCsy041((String)rowList.get(4));
                    sy04.setCsy042((String)rowList.get(5));
                    sy04.setCsy043((String)rowList.get(6));
                    userMessage.setSy02(sy02);
                    userMessage.setSy04(sy04);
                    //验证是否存在
                    List<Sy02> isExistSy02=userManagerService.isExistUser(userMessage.getSy02());
                    if(isExistSy02.size()<=0&&sy02.getCsy010()==OperateStatu.TYPE_STUDENT){
                        sy02List.add(userMessage);
                    }
                }      
            }else if(csy010==OperateStatu.TYPE_TECHO&&rowAndCol.get(1)==OperateStatu.TECHO_FILE_COLS){
                    List<List> list=ExceltoList.excel2List(newfilename); 
                   
                    for (List rowList : list) {  
                        UserMessage userMessage=new UserMessage();
                        Sy02 sy02=new Sy02();
                        Sy03 sy03=new Sy03();
                        sy02.setCsy010(Byte.parseByte(rowList.get(0).toString()));
                        sy02.setCsy021((String)rowList.get(1));
                        sy02.setCsy022((String)rowList.get(2));
                        sy03.setCsy031((String)rowList.get(3));
                        sy03.setCsy032((String)rowList.get(4));
                        userMessage.setSy02(sy02);
                        userMessage.setSy03(sy03);
                        //验证是否存在
                        List<Sy02> isExistSy02=userManagerService.isExistUser(userMessage.getSy02());
                        if(isExistSy02.size()<=0&&sy02.getCsy010()==OperateStatu.TYPE_TECHO){
                            sy02List.add(userMessage);
                        }
                    }
            }else if(csy010==OperateStatu.TYPE_TEACHER&&rowAndCol.get(1)==OperateStatu.TEACHER_FILE_COLS){
                List<List> list=ExceltoList.excel2List(newfilename); 
                
                for (List rowList : list) {  
                    UserMessage userMessage=new UserMessage();
                    Sy02 sy02=new Sy02();
                    Sy05 sy05=new Sy05();
                    sy02.setCsy010(Byte.parseByte(rowList.get(0).toString()));
                    sy02.setCsy021((String)rowList.get(1));
                    sy02.setCsy022((String)rowList.get(2));
                    sy05.setCsy051((String)rowList.get(3));
                    sy05.setCsy052((String)rowList.get(4));
                    sy05.setCsy053((String)rowList.get(5));
                    userMessage.setSy02(sy02);
                    userMessage.setSy05(sy05);
                    //验证是否存在
                    List<Sy02> isExistSy02=userManagerService.isExistUser(userMessage.getSy02());
                    if(isExistSy02.size()<=0&&sy02.getCsy010()==OperateStatu.TYPE_TEACHER){
                        sy02List.add(userMessage);
                    }
                }
            }else {
                sy02List.add("filefail");
            }
            File file=new File(newfilename);
            if(file.exists()){
                file.delete();
            }
        }        
        return sy02List;
    }
    /**
     * 下载文件
     * @return
     * @throws Exception
     */
    @RequestMapping("/downloadExampl")
    public void  downloadExampl(HttpServletResponse response,HttpServletRequest request)throws Exception{
        String realPath = getClass().getResource("/").getFile().toString().substring(1);//获取当前项目的路径
        String fileName = "/exaplefile/上传用户信息模板.xls";
        //设置content-disposition响应头控制浏览器以下载的形式打开文件，中文文件名要使用URLEncoder.encode方法进行编码，否则会出现文件名乱码  
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("content-disposition", "attachment;filename="+URLEncoder.encode("模板.xls", "UTF-8"));  
        InputStream in = new FileInputStream(realPath+fileName);//获取文件输入流  
        int len = 0;  
        byte[] buffer = new byte[1024];  
        OutputStream out = response.getOutputStream();  
        while ((len = in.read(buffer)) > 0) {  
            out.write(buffer,0,len);//将缓冲区的数据输出到客户端浏览器  
        }  
        in.close();  
        
        
        //springmvc的方法
      /*  String realPath = getClass().getResource("/").getFile().toString().substring(1)+"exaplefile/";//获取当前项目的路径
        String fileName = "上传用户信息模板.xls";
        String dfileName = new String(fileName.getBytes("utf-8"), "utf-8"); 
        HttpHeaders headers = new HttpHeaders(); 
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM); 
        headers.setContentDispositionFormData("attachment", dfileName); 
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(new File(realPath+dfileName)), headers, HttpStatus.CREATED);*/        
    }
    /**
     * 查询用户详细信息
     * @param sy02
     * @return
     * @throws Exception
     */
    @RequestMapping("/userDetail")
    @ResponseBody
    public Map userDetail(@RequestBody Sy02 sy02) throws Exception{
        Map map=userManagerService.getUserMessage(sy02);
        return map;
    }
    /**
     * 批量保存用户信息
     * @param csy010
     * @param userMessage
     * @return
     * @throws Exception
     */
    @RequestMapping("/addUserBacth")
    @ResponseBody
    public Map addUserBacth(Integer csy010,@RequestBody UserMessage[] userMessage)throws Exception{
        Map map=new HashMap();
        for (UserMessage userMessage2 : userMessage) {
           map=userManagerService.addUser(userMessage2);
        }       
        return map;
    }
    /**
     * 更新用户信息
     * @param userMessage
     * @return
     * @throws Exception
     */
    @RequestMapping("/updateUser")
    @ResponseBody
    public Map updateUser(@RequestBody UserMessage userMessage) throws Exception{
        Map map=userManagerService.updateUser(userMessage);
        return map;
    }
    /**
     * 验证输入的学院信息
     * @param csy042
     * @return
     * @throws Exception
     */
    @RequestMapping("/validateCsy042")
    @ResponseBody
    public Map validateCsy042(String csy042) throws Exception{
        Map map=userManagerService.validateCsy042(csy042);
        return map;
    }
    
    /**
     * 验证输入的班级信息
     * @param csy043
     * @return
     * @throws Exception
     */
    @RequestMapping("/validateCsy043")
    @ResponseBody
    public Map validateCsy043(String csy043) throws Exception{
        Map map=userManagerService.validateCsy043(csy043);
        return map;
    }
    /**
     * 获取用户的数量
     * @return
     * @throws Exception
     */
    @RequestMapping("/getUserCount")
    @ResponseBody
    public Map getUserCount() throws Exception{
        int i=userManagerService.getUserCount();
        Map map =new HashMap();
        map.put("count", i);
        return map;
    }
 }

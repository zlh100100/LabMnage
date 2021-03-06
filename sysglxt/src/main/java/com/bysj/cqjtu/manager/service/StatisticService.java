package com.bysj.cqjtu.manager.service;

import java.util.List;
import java.util.Map;

/**
 * 统计service
 * @author fuzhengjun
 *2017年4月6日下午4:09:06
 *
 */
public interface StatisticService {
    /**
     * 实验课程统计
     * @return
     * @throws Exception
     */
    public List<Map> coursestatistics() throws Exception;
    /**
     * 成绩统计
     * @return
     * @throws Exception
     */
    public List<Map> gradestatistics() throws Exception;
    /**
     * 查询各个学院的课程安排
     * @param csy052
     * @return
     * @throws Exception
     */
    public List<Map> courselist(String csy052)throws Exception;
    /**
     *  查询各个班级每个课程的平均成绩
     * @return
     * @throws Exception
     */
    public List<Map> classGradestatistics()throws Exception;
    /**
     * 查询各个班级每个课程的平均分布
     * @param csy043
     * @param csy060
     * @return
     */
    public List<Map> classpeopleGradestatistics(String csy043, String csy060) throws Exception;
    /**
     * 学院实验安排统计
     * @return
     * @throws Exception
     */
    public List<Map> expArrangeStatistics() throws Exception;
    /**
     * 实验安排明细
     * @param csy052
     * @return
     * @throws Exception
     */
    public List<Map> expListStatistics(String csy052) throws Exception;
    /**
     * 实验室统计
     * @return
     * @throws Exception
     */
    public List<Map> labStatistics() throws Exception;
    /**
     * 实验室列表统计
     * @return
     * @throws Exception
     */
    public List<Map> labList(String csy100) throws Exception;
    /**
     * 实验室安排统计
     * @return
     * @throws Exception
     */
    public List<Map> labArrangeStatistics() throws Exception;
    /**
     * 按照人员类型统计实验室的安排情况列表
     * @param csy010
     * @return
     * @throws Exception
     */
    public List<Map> labArrangeListStatistics(String csy010) throws Exception;
}

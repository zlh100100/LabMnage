package com.bysj.cqjtu.manager.service;

import java.util.List;
import java.util.Map;

import com.bysj.cqjtu.manager.domain.Aa10;
import com.bysj.cqjtu.util.PageEntity;
/**
 * 查询码表中的值
 * @author fuzhengjun
 *2017年4月19日下午7:38:54
 *
 */
public interface Aa10Service {
    
    /**
     * 获取所有学院
     * @return
     * @throws Exception
     */
    public List<Map> queryCsy042() throws Exception;
    /**
     * 获取学院下的班级
     * @return
     * @throws Exception
     */
    public List<Map> queryCsy043(String aaa105) throws Exception;
    /**
     * 获取码表的数量
     * @return
     * @throws Exception
     */
    public int getAa10Count() throws Exception;
    /**
     * 获取码表
     * @param pageNum
     * @param pageSize
     * @return
     * @throws Exception
     */
    public PageEntity<Aa10> queryAa10(Integer pageNum, Integer pageSize) throws Exception;
    /**
     * 删除码表
     * @param aaa100
     * @param aaa102
     * @return
     * @throws Exception
     */
    public Map deleteAa10(String aaa100, String aaa102) throws Exception;
    /**
     * 批量删除码表
     * @param ids
     * @return
     * @throws Exception
     */
    public Map deleteAa10Batch(String ids) throws Exception;
    /**
     * 添加码值
     * @param aa10
     * @return
     * @throws Exception
     */
    public Map saveAa10(Aa10 aa10) throws Exception;
    /**
     * 设置码值
     * @param aaa100
     * @return
     * @throws Exception
     */
    public Map setAaa101(String aaa100) throws Exception;
    /**
     * 验证码值
     * @param aa10
     * @return
     * @throws Exception
     */
    public Map setvalidateAa10Aaa101(Aa10 aa10) throws Exception;
    /**
     * 按条件查询码值
     * @param aa10
     * @return
     * @throws Exception
     */
    public List<Aa10> getAa10ByCondtion(Aa10 aa10) throws Exception;
    /**
     * 查询week
     * @return
     * @throws Exception
     */
    public List<Aa10> queryWeek() throws Exception;

}

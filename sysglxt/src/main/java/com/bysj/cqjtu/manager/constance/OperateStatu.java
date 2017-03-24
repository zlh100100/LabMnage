package com.bysj.cqjtu.manager.constance;

/**
 * 插入表状态
 * @author fuzhengjun
 *2017年3月24日上午11:26:22
 *
 */
public interface OperateStatu {
    /************************插入用户表状态*******************/
    public static final String ADD_SY02_SUCCESS="21";//成功
    public static final String ADD_SY02_FAIL="20";//失败
    
    /************************插入学生表状态*******************/
    public static final String ADD_SY04_SUCCESS="41";//成功
    public static final String ADD_SY04_FAIL="40";//失败
    
    /************************插入教师表状态*******************/
    public static final String ADD_SY05_SUCCESS="51";//成功
    public static final String ADD_SY05_FAIL="50";//失败
    
    /************************插入科研人员吗表状态*******************/
    public static final String ADD_SY03_SUCCESS="31";//成功
    public static final String ADD_SY03_FAIL="30";//失败
    
    /************************查询用户状态*******************/
    public static final String QUERY_SY02_IN="22";//存在
    public static final String QUERY_SY02_NOTIN="23";//不存在
    
    /************************查询学生状态*******************/
    public static final String QUERY_SY04_IN="42";//存在
    public static final String QUERY_SY04_NOTIN="43";//不存在
    
    /************************查询教师状态*******************/
    public static final String QUERY_SY05_IN="52";//存在
    public static final String QUERY_SY05_NOTIN="53";//不存在
    
    /************************查询科研状态*******************/
    public static final String QUERY_SY03_IN="32";//存在
    public static final String QUERY_SY03_NOTIN="33";//不存在
    
    /**************************添加类型**********************/
    public static final int TYPE_STUDENT=1;//学生
    public static final int TYPE_TEACHER=2;//教师
    public static final int TYPE_TECHO=3;//科研人员
    public static final int TYPE_MANAGER=4;//管理员
    
    
}

package com.bluemobi.decor.core;

/**
 * Created by wangbin on 2015/3/2.
 */
public interface Constant {

    String SESSION_MEMBER = "session_member";
    String SESSION_ADMIN_USER = "user";
    String SESSION_PC_USER = "session_pc_user";

    String ENCODING = "UTF-8";

    // 当前页码
    Integer CURRENT_PAGE_NUM = 1;

    int PAGE_DEF_SZIE = 20;
    //FANS数量初始化
    int FANS_Num = 0;
    //案例数
    int USER_OPUS = 0;
    //用户访问量
    int USER_SEENUM = 0;
    //管理员昵称

    // 用户性别
    // 男
    int USER_SEX_MALE = 0;
    // 女
    int USER_SEX_FEMALE = 1;
    // 保密
    int USER_SEX_UNKNOWN = 2;

    // 用户状态：启用
    String USER_ENABLE = "enable";
    // 用户状态：禁用
    String USER_UNABLE = "disable";

    // 用户信息可见状态
    String USER_INFO_IsSHOW_YES = "yes";
    String USER_INFO_IsSHOW_NO = "no";

    // 用户信息是否推荐
    String USER_INFO_IsRECOMMEND_YES = "yes";
    String USER_INFO_IsRECOMMEND_NO = "no";

    String CACHE_USER = "_CACHE_USER"; //request中缓存的user

    String CACHE_MOBILE_CODE = "_CACHE_CODE>"; //缓存短信接口

    String ROLE_MEMBER = "member"; // 会员
    String ROLE_ADMIN = "admin"; // 管理员

    // 评论类型
    String COMMENT_TYPE_GOODS = "goods";
    String COMMENT_TYPE_SCENE = "scene";
    String COMMENT_TYPE_SERIES = "series";
    String COMMENT_TYPE_COMMENT = "comment";


    // 收藏类型
    String COLLECTION_TYPE_GOODS = "goods";
    String COLLECTION_TYPE_SCENE = "scene";
    String COLLECTION_TYPE_SERIES = "series";

    // 点赞类型
    String PRAISE_TYPE_GOODS = "goods";
    String PRAISE_TYPE_SCENE = "scene";
    String PRAISE_TYPE_SERIES = "series";
    String PRAISE_TYPE_COMMENT = "comment";
    String PRAISE_TYPE_USER = "user";

    // recharge_record
    String RECHARGE_RECORD_PAY_TYPE_ZFB = "支付宝";
    String RECHARGE_RECORD_PAY_TYPE_CARD = "卡密充值";
    String RECHARGE_RECORD_SOURCE_MOBILE = "手机支付";
    String RECHARGE_RECORD_SOURCE_WEB = "网上支付";

    // 用户默认背景图路径
    String USER_INFO_BACKGROUND_IMAGE = "static/images/background_back1.jpg";

    /**
     * 第三方登录类型
     */
    public final static String LOGIN_TYPE_NONE = "1";
    public final static String LOGIN_TYPE_WEIXIN = "2";
    public final static String LOGIN_TYPE_QQ = "3";
    public final static String LOGIN_TYPE_XINLANG = "4";

    /**
     * 是否是第一次通过第三方登录
     */
    public final static String IF_FIRST_LOGIN_YES = "yes";
    public final static String IF_FIRST_LOGIN_NO = "no";

    // 发送验证码类型
    String SEND_CODE_FINDPASSWORD = "findPassword";
    String SEND_CODE_REGISTER = "register";

    String USER_USERTYPE_THIRDPARTY = "thirdparty";
    String USER_USERTYPE_COMMON = "common";
}

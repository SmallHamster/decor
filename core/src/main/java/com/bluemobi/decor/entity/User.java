package com.bluemobi.decor.entity;

import com.bluemobi.decor.annotation.MustConvert;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 用户
 */
@Entity
@Table(name = "user")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer id;

    // 账号
    private String account;

    // 密码
    private String password;

    // 昵称
    private String nickname;

    // 头像
    @Column(name = "head_image")
    private String headImage;

    // 背景图
    @Column(name = "background_image")
    private String backgroundImage;

    // 头像路径（第三方）
    @Column(name = "head_image_path")
    private String headImagePath;

    // 背景图路径（第三方）
    @Column(name = "background_image_path")
    private String backgroundImagePath;

    // 手机号
    private String mobile;

    // 性别
    private Integer sex;

    // 简介
    private String info;

    // 个人主页
    private String website;

    // 粉丝数
    private Integer fans;

    // 案例数
    private Integer opus;

    @ManyToOne
    @JoinColumn(name = "city_id")
    private City city;
    //城市所属省份
    @Transient
    private Province  province;


    // enable=启动，disable=禁用
    private String status;

    // 是否推荐，no=不推荐，yes=推荐
    @Column(name = "is_recommend")
    private String isRecommend;

    // 访问量
    @Column(name = "see_num")
    private Integer seeNum;

    // 推荐时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "recommend_time")
    private Date recommendTime;

    // 注册时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    // 角色类型
    @Column(name = "role_type")
    private String roleType;

    // 个人信息是否可见,no=不可见,yes=可见
    @Column(name = "is_show")
    private String isShow;

    // 用户类型：第三方账号=thirdparty，普通账号=common
    @Column(name = "user_type")
    private String userType;

    @Transient
    // 是否绑定了第三方
    private Integer isUsed;

    @Transient
    // 回复数
    private Integer reply;

    @Transient
    // 点赞数
    private Integer love;

    @Transient
    // 收藏数
    private Integer collect;

    @Transient
    // 是否点赞
    private String isLove;

    @Transient
    // 是否关注
    private String isAttention;

    @Transient
    // 关注数
    private Integer attention;

    // 星级
    @Transient
    private Integer star;

    // 是否是第三方首次登录
    @Transient
    private String ifFirstLogin;

    // 是否绑定微信
    @Transient
    private String WeiXin;

    // 是否绑定QQ
    @Transient
    private String QQ;

    // 是否绑定新浪微博
    @Transient
    private String XinLang;

    // 用户角色，只有管理员才有这个属性
    @Transient
    private TRole role;

    // 设计师发布的系列图
    @Transient
    private List<Series> seriesList;

    @Transient
    private List<Scene> sceneList;

    @Transient
    private String shortNickname;

    @Transient
    // 性别
    private String sexInfo;

    public String getShortNickname() {
        return shortNickname;
    }

    public void setShortNickname(String shortNickname) {
        this.shortNickname = shortNickname;
    }

    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    public List<Series> getSeriesList() {
        return seriesList;
    }

    public Integer getSeeNum() {
        return seeNum;
    }

    public void setSeeNum(Integer seeNum) {
        this.seeNum = seeNum;
    }

    public void setSeriesList(List<Series> seriesList) {
        this.seriesList = seriesList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public List<Scene> getSceneList() {
        return sceneList;
    }

    public void setSceneList(List<Scene> sceneList) {
        this.sceneList = sceneList;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
    }

    public String getBackgroundImage() {
        return backgroundImage;
    }

    public void setBackgroundImage(String backgroundImage) {
        this.backgroundImage = backgroundImage;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public Integer getFans() {
        return fans;
    }

    public void setFans(Integer fans) {
        this.fans = fans;
    }

    public Integer getOpus() {
        return opus;
    }

    public void setOpus(Integer opus) {
        this.opus = opus;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getIsRecommend() {
        return isRecommend;
    }

    public void setIsRecommend(String isRecommend) {
        this.isRecommend = isRecommend;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public Date getRecommendTime() {
        return recommendTime;
    }

    public void setRecommendTime(Date recommendTime) {
        this.recommendTime = recommendTime;
    }

    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
    }

    public Integer getIsUsed() {
        return isUsed;
    }

    public void setIsUsed(Integer isUsed) {
        this.isUsed = isUsed;
    }

    public String getHeadImagePath() {
        return headImagePath;
    }

    public void setHeadImagePath(String headImagePath) {
        this.headImagePath = headImagePath;
    }

    public String getBackgroundImagePath() {
        return backgroundImagePath;
    }

    public void setBackgroundImagePath(String backgroundImagePath) {
        this.backgroundImagePath = backgroundImagePath;
    }

    public Integer getReply() {
        return reply;
    }

    public void setReply(Integer reply) {
        this.reply = reply;
    }

    public Integer getLove() {
        return love;
    }

    public void setLove(Integer love) {
        this.love = love;
    }

    public Integer getCollect() {
        return collect;
    }

    public void setCollect(Integer collect) {
        this.collect = collect;
    }

    public String getIsLove() {
        return isLove;
    }

    public void setIsLove(String isLove) {
        this.isLove = isLove;
    }

    public String getIsAttention() {
        return isAttention;
    }

    public void setIsAttention(String isAttention) {
        this.isAttention = isAttention;
    }

    public Integer getAttention() {
        return attention;
    }

    public void setAttention(Integer attention) {
        this.attention = attention;
    }

    public TRole getRole() {
        return role;
    }

    public void setRole(TRole role) {
        this.role = role;
    }

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public String getIfFirstLogin() {
        return ifFirstLogin;
    }

    public void setIfFirstLogin(String ifFirstLogin) {
        this.ifFirstLogin = ifFirstLogin;
    }

    public String getWeiXin() {
        return WeiXin;
    }

    public void setWeiXin(String weiXin) {
        WeiXin = weiXin;
    }

    public String getQQ() {
        return QQ;
    }

    public void setQQ(String QQ) {
        this.QQ = QQ;
    }

    public String getXinLang() {
        return XinLang;
    }

    public void setXinLang(String xinLang) {
        XinLang = xinLang;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getSexInfo() {
        return sexInfo;
    }

    public void setSexInfo(String sexInfo) {
        this.sexInfo = sexInfo;
    }

    public User() {
    }

    public User(String account, String password, String nickname, String headImage, String backgroundImage, String headImagePath, String backgroundImagePath, String mobile, Integer sex, String info, String website, Integer fans, Integer opus, City city, Province province, String status, String isRecommend, Integer seeNum, Date recommendTime, Date createTime, String roleType, String isShow, String userType, Integer isUsed, Integer reply, Integer love, Integer collect, String isLove, String isAttention, Integer attention, Integer star, String ifFirstLogin, String weiXin, String QQ, String xinLang, TRole role, List<Series> seriesList, String shortNickname, String sexInfo) {
        this.account = account;
        this.password = password;
        this.nickname = nickname;
        this.headImage = headImage;
        this.backgroundImage = backgroundImage;
        this.headImagePath = headImagePath;
        this.backgroundImagePath = backgroundImagePath;
        this.mobile = mobile;
        this.sex = sex;
        this.info = info;
        this.website = website;
        this.fans = fans;
        this.opus = opus;
        this.city = city;
        this.province = province;
        this.status = status;
        this.isRecommend = isRecommend;
        this.seeNum = seeNum;
        this.recommendTime = recommendTime;
        this.createTime = createTime;
        this.roleType = roleType;
        this.isShow = isShow;
        this.userType = userType;
        this.isUsed = isUsed;
        this.reply = reply;
        this.love = love;
        this.collect = collect;
        this.isLove = isLove;
        this.isAttention = isAttention;
        this.attention = attention;
        this.star = star;
        this.ifFirstLogin = ifFirstLogin;
        WeiXin = weiXin;
        this.QQ = QQ;
        XinLang = xinLang;
        this.role = role;
        this.seriesList = seriesList;
        this.shortNickname = shortNickname;
        this.sexInfo = sexInfo;
    }
}

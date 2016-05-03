package com.bluemobi.decor.entity;

import com.bluemobi.decor.annotation.MustConvert;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 评论 or 回复
 * Created by tuyh on 2015/7/9.
 */
@Entity
@Table(name = "comment")
public class Comment implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "object_id")
    private Integer objectId;

    // 评论用户
    @MustConvert
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    private String content;

    private Integer pid;

    @Column(name = "object_type")
    private String objectType;

    // 发布时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    @Column(name = "praise_num")
    private Integer praiseNum;


    @Transient
    // 评论对象图路径
    private String objectImage;

    @Transient
    // 评论人头像
    private String photo;

    @Transient
    // 评论人呢称
    private String nickname;

    @Transient
    // 评论人手机号
    private String mobile;

    @Transient
    // 是否点赞
    private Integer ifLove;

    @Transient
    private String isPraise;





    // 对象类型str
    @Transient
    private String objectStr;

    // 对象类型名称
    @Transient
    private String objectName;

    @Transient
    private String objectCover;

    @Transient
    private String tags;

    @Transient
    // 该评论的回复列表
    private List<Reply> replyList;

    @Transient
    private Reply newestReply;

    public Reply getNewestReply() {
        return newestReply;
    }

    public void setNewestReply(Reply newestReply) {
        this.newestReply = newestReply;
    }

    public String getObjectCover() {
        return objectCover;
    }

    public void setObjectCover(String objectCover) {
        this.objectCover = objectCover;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getObjectId() {
        return objectId;
    }

    public void setObjectId(Integer objectId) {
        this.objectId = objectId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getObjectType() {
        return objectType;
    }

    public void setObjectType(String objectType) {
        this.objectType = objectType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getObjectImage() {
        return objectImage;
    }

    public void setObjectImage(String objectImage) {
        this.objectImage = objectImage;
    }

    public Integer getIfLove() {
        return ifLove;
    }

    public void setIfLove(Integer ifLove) {
        this.ifLove = ifLove;
    }

    public List<Reply> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<Reply> replyList) {
        this.replyList = replyList;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Integer getPraiseNum() {
        return praiseNum;
    }

    public void setPraiseNum(Integer praiseNum) {
        this.praiseNum = praiseNum;
    }

    public String getObjectName() {
        return objectName;
    }

    public void setObjectName(String objectName) {
        this.objectName = objectName;
    }

    public String getObjectStr() {
        return objectStr;
    }

    public void setObjectStr(String objectStr) {
        this.objectStr = objectStr;
    }

    public String getIsPraise() {
        return isPraise;
    }

    public void setIsPraise(String isPraise) {
        this.isPraise = isPraise;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }
}

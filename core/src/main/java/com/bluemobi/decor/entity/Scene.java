package com.bluemobi.decor.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 场景
 */
@Entity
@Table(name = "scene")
public class Scene implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // 名称
    private String name;

    // 上传用户
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // 描述
    private String info;

    // 图片
    @Column(name = "image")
    private String image;

    @Column(name = "thumbnail_image")
    private String thumbnailImage;

    @Column(name = "space_tag_ids")
    private String spaceTagIds;

    @Column(name = "style_tag_ids")
    private String styleTagIds;

    // 是否公开
    @Column(name = "is_show")
    private String isShow;

    // 是否推荐
    @Column(name = "is_recommend")
    private String isRecommend;

    // 推荐时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "recommend_time")
    private Date recommendTime;

    // 上传时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    // 查看量
    @Column(name = "see_num")
    private Integer seeNum;

    // 收藏量
    @Column(name = "collection_num")
    private Integer collectionNum;

    // 点赞量
    @Column(name = "praise_num")
    private Integer praiseNum;

    // 是否收藏了商品
    @Transient
    private String isCollection;

    // 是否点赞了
    @Transient
    private String isPraise;

    @Transient
    private Integer commentNum;

    @Transient
    private Integer goodsNum;

    //该场景图下的风格标签
    @Transient
    private List<String> styleTagName;

    //该场景图下的空间标签
    @Transient
    private List<String> spaceTagName;

    //该场景下的所有商品信息
    @Transient
    private List<Map<String, Object>> goodsMaps;

    public String getIsCollection() {
        return isCollection;
    }

    public void setIsCollection(String isCollection) {
        this.isCollection = isCollection;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getSpaceTagIds() {
        return spaceTagIds;
    }

    public void setSpaceTagIds(String spaceTagIds) {
        this.spaceTagIds = spaceTagIds;
    }

    public String getStyleTagIds() {
        return styleTagIds;
    }

    public void setStyleTagIds(String styleTagIds) {
        this.styleTagIds = styleTagIds;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
    }

    public String getIsPraise() {
        return isPraise;
    }

    public void setIsPraise(String isPraise) {
        this.isPraise = isPraise;
    }

    public String getIsRecommend() {
        return isRecommend;
    }

    public void setIsRecommend(String isRecommend) {
        this.isRecommend = isRecommend;
    }

    public Date getRecommendTime() {
        return recommendTime;
    }

    public void setRecommendTime(Date recommendTime) {
        this.recommendTime = recommendTime;
    }

    public List<String> getStyleTagName() {
        return styleTagName;
    }

    public void setStyleTagName(List<String> styleTagName) {
        this.styleTagName = styleTagName;
    }

    public List<String> getSpaceTagName() {
        return spaceTagName;
    }

    public void setSpaceTagName(List<String> spaceTagName) {
        this.spaceTagName = spaceTagName;
    }

    public List<Map<String, Object>> getGoodsMaps() {
        return goodsMaps;
    }

    public void setGoodsMaps(List<Map<String, Object>> goodsMaps) {
        this.goodsMaps = goodsMaps;
    }

    public Integer getSeeNum() {
        return seeNum;
    }

    public void setSeeNum(Integer seeNum) {
        this.seeNum = seeNum;
    }

    public Integer getCollectionNum() {
        return collectionNum;
    }

    public void setCollectionNum(Integer collectionNum) {
        this.collectionNum = collectionNum;
    }

    public Integer getPraiseNum() {
        return praiseNum;
    }

    public void setPraiseNum(Integer praiseNum) {
        this.praiseNum = praiseNum;
    }

    public String getThumbnailImage() {
        return thumbnailImage;
    }

    public void setThumbnailImage(String thumbnailImage) {
        this.thumbnailImage = thumbnailImage;
    }

    public Integer getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(Integer commentNum) {
        this.commentNum = commentNum;
    }

    public Integer getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(Integer goodsNum) {
        this.goodsNum = goodsNum;
    }
}

package com.bluemobi.decor.entity;

import com.bluemobi.decor.annotation.MustConvert;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 商品
 */
@Entity
@Table(name = "goods")
public class Goods implements Serializable {
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

    // 价格
    private String price;

    // 尺寸
    private String size;

    // 材质
    private String texture;

    // 链接
    private String link;

    // 描述
    private String info;

    @Column(name = "kind_tag_ids")
    private String kindTagIds;

    @Column(name = "space_tag_ids")
    private String spaceTagIds;

    @Column(name = "style_tag_ids")
    private String styleTagIds;

    // 上传时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    // 商品标签
    @Column(name = "tags_str")
    private String tagsStr;

    // 是否有素材
    @Column(name = "has_material")
    private String hasMaterial;

    // 是否审核通过
    @Column(name = "is_pass")
    private String isPass;

    // 是否推荐
    @Column(name = "is_recommend")
    private String isRecommend;

    // 推荐时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "recommend_time")
    private Date recommendTime;

    // 头像
    @Column(name = "cover")
    private String cover;

    @Column(name = "thumbnail_cover")
    private String thumbnailCover;

    // 查看量
    @Column(name = "see_num")
    private Integer seeNum;

    // 收藏量
    @Column(name = "collection_num")
    private Integer collectionNum;

    // 点赞量
    @Column(name = "praise_num")
    private Integer praiseNum;

    // 商品图片
    @Transient
    private List<GoodsImage> goodsImageList;

    // 是否收藏了商品
    @Transient
    private String isCollection;

    // 商品种类名称
    @Transient
    private String kindTagName;

    //该场景图下的所有空间标签名
    @Transient
    private List<String> spaceTagName;

    //该场景图下的所有风格标签名
    @Transient
    private List<String> styleTagName;

    //种类ID
    @Transient
    private Integer kindTagId;

    @Transient
    private String isPraise;

    public String getIsPraise() {
        return isPraise;
    }

    public void setIsPraise(String isPraise) {
        this.isPraise = isPraise;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getTexture() {
        return texture;
    }

    public void setTexture(String texture) {
        this.texture = texture;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getKindTagIds() {
        return kindTagIds;
    }

    public void setKindTagIds(String kindTagIds) {
        this.kindTagIds = kindTagIds;
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

    public Integer getCollectionNum() {
        return collectionNum;
    }

    public void setCollectionNum(Integer collectionNum) {
        this.collectionNum = collectionNum;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getTagsStr() {
        return tagsStr;
    }

    public void setTagsStr(String tagsStr) {
        this.tagsStr = tagsStr;
    }

    public String getHasMaterial() {
        return hasMaterial;
    }

    public void setHasMaterial(String hasMaterial) {
        this.hasMaterial = hasMaterial;
    }

    public String getIsPass() {
        return isPass;
    }

    public void setIsPass(String isPass) {
        this.isPass = isPass;
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

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public List<GoodsImage> getGoodsImageList() {
        return goodsImageList;
    }

    public void setGoodsImageList(List<GoodsImage> goodsImageList) {
        this.goodsImageList = goodsImageList;
    }

    public String getIsCollection() {
        return isCollection;
    }

    public void setIsCollection(String isCollection) {
        this.isCollection = isCollection;
    }

    public String getKindTagName() {
        return kindTagName;
    }

    public void setKindTagName(String kindTagName) {
        this.kindTagName = kindTagName;
    }

    public List<String> getSpaceTagName() {
        return spaceTagName;
    }

    public void setSpaceTagName(List<String> spaceTagName) {
        this.spaceTagName = spaceTagName;
    }

    public List<String> getStyleTagName() {
        return styleTagName;
    }

    public void setStyleTagName(List<String> styleTagName) {
        this.styleTagName = styleTagName;
    }

    public Integer getKindTagId() {
        return kindTagId;
    }

    public void setKindTagId(Integer kindTagId) {
        this.kindTagId = kindTagId;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getSeeNum() {
        return seeNum;
    }

    public void setSeeNum(Integer seeNum) {
        this.seeNum = seeNum;
    }

    public Integer getPraiseNum() {
        return praiseNum;
    }

    public void setPraiseNum(Integer praiseNum) {
        this.praiseNum = praiseNum;
    }

    public String getThumbnailCover() {
        return thumbnailCover;
    }

    public void setThumbnailCover(String thumbnailCover) {
        this.thumbnailCover = thumbnailCover;
    }
}

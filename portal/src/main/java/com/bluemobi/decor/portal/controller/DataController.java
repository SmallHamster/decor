package com.bluemobi.decor.portal.controller;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.util.MD5Util;
import com.bluemobi.decor.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


@Controller
public class DataController {

    private String[] users = {
            "13000000001=arflex",
            "13000000002=arhaus",
            "13000000003=Bocadolobo",
            "13000000004=BRABBU",
            "13000000005=buttercup",
            "13000000006=de sede",
            "13000000007=diade",
            "13000000008=DrexelHeritage",
            "13000000009=driade",
            "13000000010=ETHAN ALLEN",
            "13000000011=FontanaArte",
            "13000000012=inmod",
            "13000000013=kincaid",
            "13000000014=KOKET",
            "13000000015=Mitchell gold",
            "13000000016=moooi",
            "13000000017=pearson",
            "13000000018=Serena&LILY",
            "13000000019=thomasville",
            "13000000020=universal",
            "13000000021=potterybarn,PB"
    };

    private final static String DEFAULT_PASSWORD = "decor20160604";

    @Autowired
    private UserService userService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private SceneService sceneService;
    @Autowired
    private SeriesService seriesService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private MessageService messageService;

    @RequestMapping(value = "/dataInit")
    public void pcHomepage(HttpServletRequest request,
                             HttpServletResponse response,
                             ModelMap model) {
        System.out.print("开始初始化...");
        insertUserToDB();
        Map<String,String> userMap = getUserMap();
        initGoods(userMap);
        initScene(userMap);
    }

    private void initGoods(Map<String,String> userMap){
        List<Goods> list = goodsService.findAll();
        for(Goods goods : list){
            String name = goods.getName();
            if(StringUtils.isBlank(name)){
                continue;
            }
            try {
                int index = getIndex(name);
                if(index <= 0){
                    continue;
                }
                String n = name.substring(0,index).toLowerCase();
                String mobile = userMap.get(n);
                User user = userService.findByMobile(mobile);
                if(user == null || user.getId() == null){
                    continue;
                }
                goods.setUser(user);
                goodsService.update(goods);
            }catch (Exception e){
                System.out.print("发生异常：goodsId:" + goods.getId());
                e.printStackTrace();
            }
        }
    }

    private void initScene(Map<String,String> userMap){
        List<Scene> list = sceneService.findAll();
        for(Scene scene : list){
            String name = scene.getName();
            if(StringUtils.isBlank(name) || name.indexOf("-") <= 0){
                continue;
            }
            try {
                int index = getIndex(name);
                if(index <= 0){
                    continue;
                }
                String n = name.substring(0,index).toLowerCase();
                String mobile = userMap.get(n);
                User user = userService.findByMobile(mobile);
                if(user == null || user.getId() == null){
                    continue;
                }
                scene.setUser(user);
                sceneService.update(scene);
            }catch (Exception e){
                System.out.print("发生异常：sceneId:" + scene.getId());
                e.printStackTrace();
            }
        }
    }

    private int getIndex(String name){
        if(StringUtils.isBlank(name)){
            return -1;
        }
        int index = name.indexOf("-");
        if(index <= 0){
            index = name.indexOf("_");
        }
        return index;
    }

    // key为name，value为手机号
    private Map<String,String> getUserMap(){
        Map<String,String> userMap = new HashMap<String,String>();
        for(String str : users){
            String[] user = str.trim().split("=");
            String mobile = user[0].trim();
            String names = user[1].trim();
            if(names.indexOf(",") > 0){
                String[] nameArr = names.trim().split(",");
                for (String name : nameArr){
                    userMap.put(name.trim().toLowerCase(),mobile);
                }
            }else {
                userMap.put(names.toLowerCase(),mobile);
            }
        }
        return userMap;
    }

    // 用户插入数据，可以多次执行
    private void insertUserToDB(){
        for(String str : users){
            String[] userArr = str.trim().split("=");
            String mobile = userArr[0].trim();
            String name = userArr[1].trim();
            // 如果有多个，则取第一个
            if(name.indexOf(",") > 0){
                String[] nameArr = name.trim().split(",");
                name = nameArr[0].trim();
            }
            User user = userService.findByMobile(mobile);
            if(user == null){
                user = new User();
                user.setIsRecommend(Constant.USER_INFO_IsRECOMMEND_NO);
                user.setMobile(mobile);
                user.setAccount(mobile);
                user.setNickname(name);
                user.setPassword(MD5Util.encodeByMD5(DEFAULT_PASSWORD));
                user.setCreateTime(new Date());
                user.setRoleType(Constant.ROLE_MEMBER);
                user.setStatus(Constant.USER_ENABLE);
                user.setSex(Constant.USER_SEX_UNKNOWN);
                user.setIsShow(Constant.USER_INFO_IsSHOW_YES);
                user.setOpus(0);
                user.setFans(0);
                user.setHeadImage("static/images/defaultPhoto.png");
                userService.pcRegister(user);
                System.out.print("新增用户成功:"+name);
            }else {
                System.out.print("用户已经存在:"+name + "-" + mobile);
            }
        }
    }

    // 点赞，查询，关注等数据，如果为0，则插入100以内的随机数
    @RequestMapping(value = "/numberInit")
    public void numberInit() {
        // 商品表
        List<Goods> goodsList = goodsService.findAll();
        if(CollectionUtils.isNotEmpty(goodsList)){
            for(Goods goods : goodsList){
                if(goods.getPraiseNum() == null || goods.getPraiseNum() == 0){
                    goods.setPraiseNum(getNum());
                }
                if(goods.getSeeNum() == null || goods.getSeeNum() == 0){
                    goods.setSeeNum(getNum());
                }
                try {
                    goodsService.update(goods);
                }catch (Exception e){
                    e.printStackTrace();
                }

            }
        }
        // 场景图
        List<Scene> sceneList = sceneService.findAll();
        if(CollectionUtils.isNotEmpty(sceneList)){
            for(Scene scene : sceneList){
                if(scene.getPraiseNum() == null || scene.getPraiseNum() == 0){
                    scene.setPraiseNum(getNum());
                }
                if(scene.getSeeNum() == null || scene.getSeeNum() == 0){
                    scene.setSeeNum(getNum());
                }
                if(scene.getCollectionNum() == null || scene.getCollectionNum() == 0){
                    scene.setCollectionNum(getNum());
                }
                try {
                    sceneService.update(scene);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        // 系列图
        List<Series> seriesList = seriesService.findAll();
        if(CollectionUtils.isNotEmpty(seriesList)){
            for(Series series : seriesList){
                if(series.getPraiseNum() == null || series.getPraiseNum() == 0){
                    series.setPraiseNum(getNum());
                }
                if(series.getSeeNum() == null || series.getSeeNum() == 0){
                    series.setSeeNum(getNum());
                }
                if(series.getCollectionNum() == null || series.getCollectionNum() == 0){
                    series.setCollectionNum(getNum());
                }
                try {
                    seriesService.update(series);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        // 评论
        List<Comment> commentList = commentService.findAll();
        if(CollectionUtils.isNotEmpty(commentList)){
            for(Comment comment : commentList){
                if(comment.getPraiseNum() == null || comment.getPraiseNum() == 0){
                    comment.setPraiseNum(getNum());
                }
                try {
                    commentService.update(comment);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        // 资讯
        List<Message> messageList = messageService.findAll();
        if(CollectionUtils.isNotEmpty(messageList)){
            for(Message message : messageList){
                if(message.getCollectionNum() == null || message.getCollectionNum() == 0){
                    message.setCollectionNum(getNum());
                }
                try {
                    messageService.update(message);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }


    }

    public int getNum(){
        return new Random().nextInt(100);
    }
}

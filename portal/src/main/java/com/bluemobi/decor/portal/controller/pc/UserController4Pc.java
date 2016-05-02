package com.bluemobi.decor.portal.controller.pc;


import com.bluemobi.decor.comparator.CreateTimeComparator;
import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.ERROR_CODE;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.entity.Collection;
import com.bluemobi.decor.portal.cache.CacheService;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.*;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.utils.JsonUtil;
import com.bluemobi.decor.utils.SessionUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * 首页
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/pc/user")
public class UserController4Pc extends CommonController {

    @Autowired
    private UserService userService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private SpaceTagService spaceTagService;

    @Autowired
    private UserThirdService userThirdService;

    @Autowired
    private AttentionService attentionService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private SeriesSceneService seriesSceneService;

    @Autowired
    private SceneService sceneService;

    @Autowired
    private SeriesService seriesService;

    @Autowired
    private FavoriteService favoriteService;

    @Autowired
    private CollectionMessageService collectionMessageService;

    @Autowired
    private MessageService messageService;

    @Autowired
    private CollectionService collectionService;

    @Autowired
    private SeriesTagService seriesTagService;

    @Autowired
    private CommentUpdateStatusService commentUpdateStatusService;

    @Autowired
    private FeedbackService feedbackService;
    @Autowired
    private MaterialService materialService;

    @Resource(name = "cacheTempCodeServiceImpl")
    private CacheService<String> cacheService;

    String account = "";

    // 注册
    @RequestMapping(value = "/register")
    public void register(HttpServletRequest request,
                         HttpServletResponse response,
                         String mobile,
                         String password,
                         String nickname,
                         String code) {
        try {
            if (StringUtils.isEmpty(mobile)) {
                WebUtil.print(response, new Result(false).msg("手机号不能为空!"));
                return;
            }
            if (StringUtils.isEmpty(password)) {
                WebUtil.print(response, new Result(false).msg("密码不能为空!"));
                return;
            }
            if (StringUtils.isEmpty(nickname)) {
                WebUtil.print(response, new Result(false).msg("昵称不能为空!"));
                return;
            }
            if (StringUtils.isEmpty(code)) {
                WebUtil.print(response, new Result(false).msg("手机验证码不能为空!"));
                return;
            }

            String cacheCode = cacheService.get(mobile);

            // 检测验证码是否过期
            if (StringUtils.isEmpty(cacheCode)) {
                WebUtil.print(response, new Result(false).msg("验证码超时!"));
                return;
            }

            // 检测验证码是否正确
            if (!code.equals(cacheCode)) {
                WebUtil.print(response, new Result(false).msg("验证码错误!"));
                return;
            }

            User user = new User();
            user.setIsRecommend(Constant.USER_INFO_IsRECOMMEND_NO);
            user.setMobile(mobile);
            user.setAccount(mobile);
            user.setNickname(nickname);
            user.setPassword(MD5Util.encodeByMD5(password));
            user.setCreateTime(new Date());
            user.setRoleType(Constant.ROLE_MEMBER);
            user.setStatus(Constant.USER_ENABLE);
            user.setSex(Constant.USER_SEX_UNKNOWN);
            user.setIsShow(Constant.USER_INFO_IsSHOW_YES);
            user.setOpus(0);
            user.setFans(0);
            user.setHeadImage("static/images/defaultPhoto.png");
            String flag = userService.pcRegister(user);

            if ("mobileIsEmpty".equals(flag)) {
                WebUtil.print(response, new Result(false).msg("手机号不能为空!"));
                return;
            }
            if ("mobileIsExist".equals(flag)) {
                WebUtil.print(response, new Result(false).msg("手机号已经存在!"));
                return;
            }

            cacheService.remove(mobile);
            WebUtil.print(response, new Result(true).msg("注册成功"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    /**
     * 发送验证码
     *
     * @param response
     * @param request
     * @param mobile
     */
    @RequestMapping("/sendMessage")
    public void sendMessage(HttpServletResponse response,
                            HttpServletRequest request,
                            String mobile) {
        if (mobile == null) {
            WebUtil.print(response, new Result(false).msg("手机号不能为空!"));
            return;
        }

        User user = userService.findByMobile(mobile);
        if (user != null) {
            WebUtil.print(response, new Result(false).msg("手机号已经存在!"));
            return;
        }

        // 生成验证码
        String code = getCode(6);

        String result = null;
        try {
            result = MsgSmsUtil.sendSms(mobile, "您的验证码是：【" + code + "】。请不要把验证码泄露给其他人。");
            if (null == result) {
                WebUtil.printApi(response, new Result(false).msg(ERROR_CODE.ERROR_CODE_0001));
                return;
            }
            cacheService.put(mobile, code);
            WebUtil.print(response, new Result(true).msg("发送成功,请在手机查收!"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 找回密码发送验证码
     *
     * @param response
     * @param request
     * @param mobile
     */
    @RequestMapping("/sendMessage2FindPassword")
    public void sendMessage2FindPassword(HttpServletResponse response,
                                         HttpServletRequest request,
                                         String mobile) {
        String sendErrorMsg = "发送验证码失败,请联系管理员!";
        try {
            if (mobile == null) {
                WebUtil.print(response, new Result(false).msg("手机号不能为空!"));
                return;
            }

            User user = userService.findByMobile(mobile);
            if (user == null) {
                WebUtil.print(response, new Result(false).msg("该手机尚未注册，请重新输入手机号！"));
                return;
            }

            // 生成验证码
            String code = getCode(6);

            String result = null;

            result = MsgSmsUtil.sendSms(mobile, "【华科Decor】您的验证码为" + code + "。(请勿告知他人)");
            if (null == result) {
                WebUtil.print(response, new Result(false).msg(sendErrorMsg));
                return;
            }

            if (result.contains("<returnstatus>Success</returnstatus>")) {
                cacheService.put(mobile, code);
                WebUtil.print(response, new Result(true).msg("发送成功,请在手机查收!"));
            } else {
                WebUtil.print(response, new Result(false).msg(sendErrorMsg));
            }
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg(sendErrorMsg));
        }

    }

    /**
     * 找回密码验证验证码
     *
     * @param response
     * @param request
     * @param mobile
     */
    @RequestMapping("/pcFindPasswordCheckCode")
    public void pcFindPasswordCheckCode(HttpServletResponse response,
                                        HttpServletRequest request,
                                        String mobile,
                                        String code) {
        try {
            String cacheCode = cacheService.get(mobile);
            if (StringUtils.isNotEmpty(code) && code.equals(cacheCode)) {
                WebUtil.print(response, new Result(true).msg("验证成功!"));
            } else {
                WebUtil.print(response, new Result(false).msg("验证码错误!"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }

    }

    /**
     * 发送验证码
     *
     * @param response
     * @param request
     * @param mobile
     */
    @RequestMapping("/pcResetPassword")
    public void pcResetPassword(HttpServletResponse response,
                                HttpServletRequest request,
                                String mobile,
                                String password) {
        try {
            userService.pcResetPassword(mobile, MD5Util.encodeByMD5(password));
            WebUtil.print(response, new Result(true).msg("重置成功"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    public static String getCode(int length) {
        Random random = new Random();
        String result = "";
        for (int i = 0; i < length; i++) {
            result += random.nextInt(10);
        }
        return result;
    }

    /**
     * 验证手机验证码
     *
     * @param mobile
     * @param code
     * @return
     */
    private boolean checkMobileCode(String mobile,
                                    String code) {

        String cacheCode = cacheService.get(mobile);
        if (code.equals(cacheCode)) {
            return true;
        } else {
            //if(cacheCode!=null){
            //  cacheService.remove(mobile);
            //}
            return false;
        }
    }

    /**
     * 保存意见反馈
     *
     * @param response
     * @param request
     */
    @RequestMapping("/pcSaveFeedback")
    public void pcSaveFeedback(HttpServletResponse response,
                               HttpServletRequest request,
                               String content) {
        try {
            User user = (User) SessionUtils.get(Constant.SESSION_PC_USER);
            Feedback feedback = new Feedback();
            feedback.setUser(user);
            feedback.setContent(content);
            feedback.setCreateTime(new Date());
            feedbackService.create(feedback);
            WebUtil.print(response, new Result(true).msg("意见提交成功"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("意见提交失败!"));
        }
    }

    // 登录
    @RequestMapping(value = "/login")
    public void login(HttpServletRequest request,
                      HttpServletResponse response,
                      String username,
                      String password,String remark) {
        try {
            password = MD5Util.encodeByMD5(password);
            User user = userService.pcLogin(username, password);
            if (user != null) {
                String nickname = user.getNickname();
                String shortNickname = nickname;
                if (nickname != null && nickname.length() > 4) {
                    shortNickname = nickname.substring(0, 4) + "...";
                }
                user.setShortNickname(shortNickname);

                int loginMaxAge = 30 * 24 * 60 * 60; // 定义cookies的生命周期，这里是一个月。单位为秒
                CookiesUtils.addCookie(response, "userId", user.getId().toString(), loginMaxAge);
                WebUtil.print(response, new Result(true).data(user));
            } else {
                WebUtil.print(response, new Result(false).msg("用户名或密码错误!"));
            }
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    /**
     * 用户第三方登录
     *
     * @param request
     * @param response
     */
    @RequestMapping("/tLogin")
    public String tLogin(HttpServletRequest request,
                       HttpServletResponse response,
                       String code) {
        String open_id = "";
        String type = "";

        // type:get_user_info
        // code:传回的code值
        // appid:申请到的appid值 ( 网页上点击应用名称获取 )
        // token:申请到的token值 ( 网页上点击应用名称获取 )
        Map<String, String> map = new HashMap<String, String>();
        map.put("type", "get_user_info");
        map.put("code", code);
        map.put("appid", "156a86c6f2d4e2");
        map.put("token", "9e51520c6cc571d768e27faa1ee66035");

        String msg = HttpUtils.sendPost4String("http://open.51094.com/user/auth.html", map);
        Map<String, Object> temp = JsonUtils.getMapFromJsonObjStr(msg);

        // 判断当前第三方登录类型
        if (temp.get("from").equals("qq")) {
            type = "3";
        } else if (temp.get("from").equals("weibo")) {
            type = "4";
        }

        // 获取第三方唯一openid
        open_id = temp.get("uniq").toString();

        // 转换性别字段
        Integer sex = 1;
        if(temp.get("sex").toString().equals("1")){
            sex = 0;
        }

        // 执行openId登录操作
        UserThird openUser = userThirdService.iFindByOpenId(open_id, type);
        if (null == openUser) {
            // 如果通过openID找不到用户信息，则后台生成一个新用户，同时绑定当前openID，然后返回新生成的用户信息
            User userPlus = new User();
            userPlus.setIsRecommend(Constant.USER_INFO_IsRECOMMEND_NO);
            userPlus.setRoleType(Constant.ROLE_MEMBER);
            userPlus.setStatus(Constant.USER_ENABLE);
            userPlus.setSex(sex);
            userPlus.setIsShow(Constant.USER_INFO_IsSHOW_YES);
            userPlus.setCreateTime(new Date());
            userPlus.setFans(0);
            userPlus.setOpus(0);
            userPlus.setNickname(temp.get("name").toString());
            userPlus.setHeadImage(temp.get("img").toString());
            userPlus.setUserType(Constant.USER_USERTYPE_THIRDPARTY);
            userPlus.setBackgroundImage(Constant.USER_INFO_BACKGROUND_IMAGE);

            userPlus.setAccount(account);
            userPlus.setPassword(MD5Util.encodeByMD5(account));

            User flagUser = userService.iRegister(userPlus);
            // 判断是否注册成功
            if (null != flagUser) {
                // 注册成功后，绑定openID，同时返回用户信息
                // 执行绑定操作
                userService.bindingOpenId(flagUser, open_id, type);

                // 返回用户信息
                User newUser = userService.pcLoginPlus(flagUser.getNickname(), flagUser.getPassword());
                String nickname = newUser.getNickname();
                String shortNickname = nickname;
                if (nickname != null && nickname.length() > 4) {
                    shortNickname = nickname.substring(0, 4) + "...";
                }
                newUser.setShortNickname(shortNickname);
                // WebUtil.print(response, new Result(true).data(newUser));
                SessionUtils.put("user",newUser);
            } else {
                // WebUtil.printApi(response, new Result(false).msg("服务器异常"));
            }
        } else {
            User user = openUser.getUser();
            if (user.getStatus().equals(Constant.USER_ENABLE)) {
                try {
                    User newUser = userService.pcLoginPlus(user.getNickname(), user.getPassword());
                    if (null != newUser) {
                        String nickname = newUser.getNickname();
                        String shortNickname = nickname;
                        if (nickname != null && nickname.length() > 4) {
                            shortNickname = nickname.substring(0, 4) + "...";
                        }
                        newUser.setShortNickname(shortNickname);
                        // WebUtil.print(response, new Result(true).data(newUser));
                        SessionUtils.put("user",newUser);
                    } else {
                        // WebUtil.print(response, new Result(false).msg("用户名或密码错误!"));
                    }
                } catch (Exception e) {
                    // WebUtil.print(response, new Result(false).msg("操作失败!"));
                }
            } else {
                // WebUtil.printApi(response, new Result(false).msg("用户被禁用"));
            }
        }

        return "pc/首页";
    }

    // 登出
    @RequestMapping(value = "/logout")
    public void logout(HttpServletRequest request,
                       HttpServletResponse response) {
        try {
            SessionUtils.remove(Constant.SESSION_PC_USER);
            WebUtil.print(response, new Result(true).msg("操作成功!"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // page to 重置密码
    @RequestMapping(value = "/toresetpwd")
    public String resetpwd() {
        return "pc/pc-找回密码";
    }

    // 显示省份
    @RequestMapping(value = "/showProvince")
    public void showProvince(HttpServletRequest request,
                             HttpServletResponse response) {
        try {
            List<Province> list = userService.showProvince();
            WebUtil.print(response, new Result(true).data(list));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // 显示城市
    @RequestMapping(value = "/showCity")
    public void showProvince(HttpServletRequest request,
                             HttpServletResponse response,
                             Integer provinceId) {
        try {
            List<City> list = userService.showCity(provinceId);
            WebUtil.print(response, new Result(true).data(list));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //用户分页
    @RequestMapping(value = "/pageUsers")
    public void showPageUsers(HttpServletRequest request, HttpServletResponse response, Integer pageNum,
                              Integer pageSize, Integer cityId, String name, Integer provinceId, String sort) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 4;
            }
            Page<User> page = userService.pcPage(pageNum, pageSize, cityId, sort, name, provinceId);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //FANS 最多四位
    @RequestMapping(value = "/maxFans")
    public void showMaxFans(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<User> list = userService.maxFans();
            WebUtil.print(response, new Result(true).data(list));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // forward to 资讯详情页
    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                         HttpServletRequest request,
                         Integer userId) {
        User user = userService.getById(userId);
        /*设置访问量*/
        if (user.getSeeNum() == null) {
            user.setSeeNum(1);
        }
        user.setSeeNum(user.getSeeNum() + 1);
        /*查询收藏量 和被收藏量*/
        List<Integer> list = attentionService.findFansNum(user);
        Integer collect = list.get(0);
        Integer attention = list.get(1);
        user.setAttention(attention);
        user.setCollect(collect);
        modelMap.put("user", user);
        return "pc/设计师详情页";
    }

    // forward to 个人主页
    @RequestMapping(value = "/detailHomePage")
    public String detailHomePage(ModelMap modelMap,
                                 HttpServletRequest request,
                                 Integer userId) {
        User user = (User) SessionUtils.get(Constant.SESSION_PC_USER);
        if (user != null) {
            user = userService.getById(user.getId());
            SessionUtils.put(Constant.SESSION_PC_USER, user);
            /*设置访问量*/
            if (user.getSeeNum() == null) {
                user.setSeeNum(1);
            }
            // user.setSeeNum(user.getSeeNum() + 1);
        /*查询收藏量 和被收藏量*/
            List<Integer> list = attentionService.findFansNum(user);
            Integer collect = list.get(0);
            Integer attention = list.get(1);
            user.setAttention(attention);
            user.setCollect(collect);
            userService.update(user);

            String nickname = user.getNickname();
            String shortNickname = nickname;
            if (nickname != null && nickname.length() > 4) {
                shortNickname = nickname.substring(0, 4) + "...";
            }
            user.setShortNickname(shortNickname);

            modelMap.put("user", user);

            switch (user.getSex()) {
                case 0:
                    user.setSexInfo("男");
                    break;
                case 1:
                    user.setSexInfo("女");
                    break;
                default:
                    user.setSexInfo("保密");
                    break;
            }

            return "pc/个人主页";
        } else {
            return "pc/首页";
        }
    }

    // forward to 个人主页
    @RequestMapping(value = "/detailPage")
    public String detailPage(ModelMap modelMap,
                             HttpServletRequest request,
                             Integer userId) {
        User user = userService.getById(userId);
        if (user != null) {
            /*设置访问量*/
            if (user.getSeeNum() == null) {
                user.setSeeNum(1);
            }
            user.setSeeNum(user.getSeeNum() + 1);
        /*查询收藏量 和被收藏量*/
            List<Integer> list = attentionService.findFansNum(user);
            Integer collect = list.get(0);
            Integer attention = list.get(1);
            user.setAttention(attention);
            user.setCollect(collect);
            userService.update(user);

            String nickname = user.getNickname();
            String shortNickname = nickname;
            if (nickname != null && nickname.length() > 4) {
                shortNickname = nickname.substring(0, 4) + "...";
            }
            user.setShortNickname(shortNickname);

            modelMap.put("user", user);

            switch (user.getSex()) {
                case 0:
                    user.setSexInfo("男");
                    break;
                case 1:
                    user.setSexInfo("女");
                    break;
                default:
                    user.setSexInfo("保密");
                    break;
            }

            Series topSeries = new Series();
            Page<Series> page = seriesService.pcFindSeriesPage(user, 1, 1);
            List<Series> seriesList = page.getContent();
            if(CollectionUtils.isNotEmpty(seriesList)){
                topSeries = seriesList.get(0);
                List<Scene> sceneList = seriesSceneService.findSceneListBySeriesId(topSeries.getId());
                topSeries.setSceneList(sceneList);
            }
            modelMap.put("topSeries", topSeries);

            // 最新互动
            Page<Comment> commentPage = commentService.findCommentPage(userId, 1, 1);
            Comment newestComment = null;
            if(commentPage != null && CollectionUtils.isNotEmpty(commentPage.getContent())){
                newestComment = new Comment();
                newestComment = commentPage.getContent().get(0);
                List<Comment> replyList =commentService.listReply(newestComment.getId());
                Reply reply = new Reply();
                if(CollectionUtils.isNotEmpty(replyList)){
                    Comment temp = replyList.get(0);
                    reply.setHeadImage(temp.getUser().getHeadImage());
                    reply.setCreateTime(temp.getCreateTime());
                    reply.setContent(temp.getContent());
                }
                newestComment.setNewestReply(reply);

                // 对象信息
                if (newestComment.getObjectType().equals("series")){
                    Series series = seriesService.getById(newestComment.getObjectId());
                    newestComment.setObjectCover(series.getCover());
                    newestComment.setObjectName(series.getInfo());
                    if(series.getSeriesTag() != null){
                        newestComment.setTags(series.getSeriesTag().getName());
                    }else {
                        newestComment.setTags("");
                    }
                }else if (newestComment.getObjectType().equals("scene")){
                    Scene scene=sceneService.getById(newestComment.getObjectId());
                    newestComment.setObjectCover(scene.getImage());
                    newestComment.setObjectName(scene.getName());
                    String tags = spaceTagService.getTagStr(scene.getSpaceTagIds());
                    newestComment.setTags(tags);
                }else if (newestComment.getObjectType().equals("goods")){
                    Goods goods=goodsService.getById(newestComment.getObjectId());
                    newestComment.setObjectCover(goods.getCover());
                    newestComment.setObjectName(goods.getName());
                    String tags = spaceTagService.getTagStr(goods.getSpaceTagIds());
                    newestComment.setTags(tags);
                }
            }
            modelMap.put("newestComment", newestComment);

            return "pc/设计师详情页";
        } else {
            return "pc/首页";
        }
    }

    //查询指定用户的关注对象分页
    @RequestMapping(value = "/attentionPage")
    public void pcFindAttentionPage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 20;
            }
            User user = userService.getById(userId);
            Page<Attention> page = attentionService.pcFindAttentionPage(user, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询指定用户的fans对象分页
    @RequestMapping(value = "/fansPage")
    public void pcFindFansPage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 20;
            }
            User user = userService.getById(userId);
            Page<Attention> page = attentionService.pcFindFansPage(user, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询指定用户的所有商品分页
    @RequestMapping(value = "/goodsPage")
    public void goodsPage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 18;
            }
            User user = userService.getById(userId);
            Page<Goods> page = goodsService.pcFindGoodsPage(user, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询指定用户的所有场景分页
    @RequestMapping(value = "/scenePage")
    public void scenePage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 18;
            }
            User user = userService.getById(userId);
            Page<Scene> page = sceneService.pcFindScenePage(user, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询指定用户的所有系列图分页
    @RequestMapping(value = "/seriesPage")
    public void seriesPage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 9;
            }
            User user = userService.getById(userId);
            Page<Series> page = seriesService.pcFindSeriesPage(user, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询指定用户的所有评论分页
    @RequestMapping(value = "/commentPage")
    public void commentPage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 4;
            }
            Page<CommentUpdateStatus> page = commentUpdateStatusService.pcFindCommentPage(userId, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询指定用户的所有评论分页
    @RequestMapping(value = "/findCommentPage")
    public void findCommentPage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 8;
            }
            Page<Comment> page = commentService.findCommentPage(userId, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询指定用户的所有画板素材
    @RequestMapping(value = "/materialPage")
    public void materialPage(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer pageNum, Integer pageSize) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 12;
            }
            Page<Material> page = materialService.pcPageMy(pageNum, pageSize, userId);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //查询当前用户是否被登录用户关注
    @RequestMapping(value = "/ajaxIsAttention")
    public void ajaxIsAttention(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer sessionUserId) {
        try {

            boolean isAttentionByUser = userService.IsAttentionByUser(userId, sessionUserId);
            WebUtil.print(response, new Result(true).data(isAttentionByUser));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //更改关注用户状态
    @RequestMapping(value = "/updateIsAttention")
    public void updateIsAttention(HttpServletRequest request, HttpServletResponse response, Integer userId, Integer sessionUserId, boolean addOrDel) {
        try {
            userService.updateIsAttention(userId, sessionUserId, addOrDel);
            if (addOrDel) {
                WebUtil.print(response, new Result(true).msg("关注成功!"));
            } else {
                WebUtil.print(response, new Result(true).msg("取消成功!"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("关注失败!"));
        }
    }

    //更改用户FANS数量
    @RequestMapping(value = "/ajaxUpdateFansNum")
    public void UpdateFansNum(HttpServletRequest request, HttpServletResponse response, Integer userId, boolean addOrDel) {
        try {

            userService.updateFansNum(userId, addOrDel);
            WebUtil.print(response, new Result(true).msg("操作成功"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // 收藏夹封面图查询
    @RequestMapping(value = "/favoriteList")
    public void ajaxFavoriteList(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Integer userId) {
        try {
            List<Favorite> favoriteList = favoriteService.listByUserId(userId);
            for (Favorite favorite : favoriteList) {
                String cover = favoriteService.cover(favorite.getId());
                favorite.setCover(cover);
            }

            WebUtil.print(response, new Result(true).data(favoriteList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // 最新上传的4张图片查询
    @RequestMapping(value = "/imagesList")
    public void imagesList(HttpServletRequest request,
                           HttpServletResponse response,
                           Integer userId) {
        try {
            User user = userService.getById(userId);
            List<PicObj> picObjList = goodsService.pcFindPicObj(user);
            Collections.sort(picObjList, new CreateTimeComparator());
            List<PicObj> picList = new ArrayList<PicObj>();
            if (picObjList.size() <= 4) {
                for (PicObj picObj : picObjList) {
                    picList.add(picObj);
                }
            } else {
                picList.add(picObjList.get(0));
                picList.add(picObjList.get(1));
                picList.add(picObjList.get(2));
                picList.add(picObjList.get(3));
            }


            WebUtil.print(response, new Result(true).data(picList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // 收藏夹封面图查询
    @RequestMapping(value = "/pageFavorite")
    public void pageFavorite(HttpServletRequest request,
                             HttpServletResponse response,
                             Integer userId, Integer pageNum, Integer pageSize) {
        try {

            Page<Favorite> page = favoriteService.pageFavorite(userId, pageSize, pageNum);
            List<Favorite> favoriteList = page.getContent();
            for (Favorite favorite : favoriteList) {
                String cover = favoriteService.cover(favorite.getId());
                favorite.setCover(cover);
            }
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    //删除资讯
    @RequestMapping(value = "/delMessageById")
    public void delFavorite(HttpServletRequest request,
                            HttpServletResponse response,
                            Integer userId, Integer messageId) {
        try {
            messageService.cancelledMessage(messageId, userId);
            messageService.messageCollectionAdd(messageId, false);
            WebUtil.print(response, new Result(true).msg("删除成功!"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("删除失败!"));
        }
    }

    //新增收藏夹
    @RequestMapping(value = "/newFavorite")
    public void newFavorite(HttpServletRequest request,
                            HttpServletResponse response,
                            Integer userId, String name, String info) {
        try {
            Favorite favorite = new Favorite();
            favorite.setName(name);
            favorite.setInfo(info);
            User user = new User();
            user.setId(userId);
            favorite.setUser(user);
            favoriteService.create(favorite);
            WebUtil.print(response, new Result(true).msg("新建成功!"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("失败!"));
        }
    }

    // 收藏夹封面图查询
    @RequestMapping(value = "/pageMessage")
    public void ajaxPageMessage(HttpServletRequest request,
                                HttpServletResponse response,
                                Integer userId, Integer pageNum, Integer pageSize) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 9;
        }
        try {
            Page<CollectionMessage> page = collectionMessageService.pcPageCollectionWithUser(userId, pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // 查询单个收藏夹具体信息分页
    @RequestMapping(value = "/pageShowFavorite")
    public void pageShowFavorite(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Integer favoriteId, Integer pageSize, Integer pageNum) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 18;
        }
        try {
            Page<Collection> page = collectionService.pageFavorite(favoriteId, pageSize, pageNum);
            //判断类型
            List<Collection> collectionsList = page.getContent();
            for (Collection collection : collectionsList) {
                System.out.println(collection.getFavorite().getId() + collection.getFavorite().getName());
                if (collection.getObjectType().equals("series")) {
                    Series series = seriesService.getById(collection.getObjectId());
                    SeriesTag seriesTag = seriesTagService.getById(series.getSeriesTag().getId());
                    collection.setName(seriesTag.getName());
                    collection.setCover(series.getCover());
                } else if (collection.getObjectType().equals("scene")) {
                    Scene scene = sceneService.getById(collection.getObjectId());
                    collection.setName(scene.getName());
                    collection.setCover(scene.getImage());
                } else if (collection.getObjectType().equals("goods")) {
                    Goods goods = goodsService.getById(collection.getObjectId());
                    collection.setName(goods.getName());
                    collection.setCover(goods.getCover());
                }
            }
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

}

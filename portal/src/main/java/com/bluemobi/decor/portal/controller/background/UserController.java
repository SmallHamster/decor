package com.bluemobi.decor.portal.controller.background;


import com.bluemobi.decor.common.factory.DataTableFactory;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.CookiesUtils;
import com.bluemobi.decor.portal.util.MD5Util;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.CityService;
import com.bluemobi.decor.service.MessageService;
import com.bluemobi.decor.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * user管理
 * Created by gaoll on 2015/3/11.
 */
@Controller
@RequestMapping(value = "/backend/user")
public class UserController extends CommonController {

    @Autowired
    private UserService userService;

    @Autowired
    private CityService cityService;

    @Autowired
    private MessageService messageService;

    @RequestMapping(value = "/index")
    public String index() {
        return "会员列表";
    }


    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request,
                        HttpServletResponse response,
                        String error,
                        ModelMap model) {
        if (StringUtils.isNotBlank(error)) {
            model.addAttribute("error", error);
        }
        // 先读取cookies，如果存在，则将用户名回写到输入框
        Map<String, Object> params = CookiesUtils.ReadCookieMap(request);
        if (params != null && params.size() != 0) {
            String name = (String) params.get("name");
            model.put("name", name);
        }
        return "登录";
    }

    @RequestMapping(value = "/login/check")
    public String checkLogin(String username,
                             String password,
                             HttpServletRequest request, HttpServletResponse response,
                             String remark,
                             ModelMap model) {
        Boolean success = userService.backendLogin(username, password);
        if (success) {
            // 登录成功后，将用户名放入cookies
            if (StringUtils.isNotEmpty(remark)) {
                int loginMaxAge = 30 * 24 * 60 * 60; // 定义cookies的生命周期，这里是一个月。单位为秒
                CookiesUtils.addCookie(response, "name", username, loginMaxAge);
            } else {
                CookiesUtils.delCookie(response, "name");
            }
            return "redirect:/";
        } else {
            model.addAttribute("error", "用户名或密码错误!");
            return "登录";
        }
    }

    @RequestMapping(value = "/listToMain")
    public void listToMain(HttpServletRequest request,
                           HttpServletResponse response) {
        try {
            Page<User> page = userService.PageToMain(1, 2);
            Map<String, Object> result = DataTableFactory.fitting(1, page);
            WebUtil.print(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/list")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer draw,
                     Integer start,
                     Integer length,
                     Integer id,
                     String nickname,
                     String account) {
        try {
            int pageNum = getPageNum(start, length);
            Page<User> page = userService.BAdmin(pageNum, length, nickname, account, id);
            Map<String, Object> result = DataTableFactory.fitting(draw, page);
            WebUtil.print(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/batchChangeStatus")
    public void batchChangeStatus(HttpServletRequest request,
                                  HttpServletResponse response,
                                  String ids,
                                  String status) {
        try {
            userService.batchChangeStatus(ids, status);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    @RequestMapping("/changeStatus")
    public void changeStatus(HttpServletRequest request,
                             HttpServletResponse response,
                             Integer id,
                             String status) {
        String msg = "";
        if (status.equals("enable")) {
            msg = "启用";
        } else {
            msg = "禁用";
        }
        try {
            userService.changeStatus(id, status);
            WebUtil.print(response, new Result(true).msg(msg + "成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg(msg + "失败！"));
        }
    }

    @RequestMapping("/changeRecommend")
    public void changeRecommend(HttpServletRequest request,
                                HttpServletResponse response,
                                Integer id,
                                String isRecommend) {
        String msg = "";
        if (isRecommend.equals("yes")) {
            msg = "推荐";
        } else {
            msg = "取消推荐";
        }
        try {
            userService.changeRecommend(id, isRecommend);
            WebUtil.print(response, new Result(true).msg(msg + "成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg(msg + "失败！"));
        }
    }

    @RequestMapping(value = "/delete")
    public void delete(HttpServletRequest request,
                       HttpServletResponse response,
                       Integer id) {
        try {
            userService.deleteById(id);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    @RequestMapping(value = "/shows")
    public String shows(HttpServletRequest request,
                        HttpServletResponse response,
                        Integer id,
                        ModelMap model) {
        User user = userService.getById(id);
        model.put("user", user);
        if (null != user.getCity()) {
            model.put("cityId", user.getCity().getId());
            if (null != user.getCity().getProvince()) {
                model.put("provinceId", user.getCity().getProvince().getId());
            } else {
                model.put("provinceId", 1);
            }
        } else {
            model.put("cityId", 1);
            model.put("provinceId", 1);
        }
        return "查看会员";
    }

    @RequestMapping(value = "/updateUserInfo")
    public void updateUserInfo(HttpServletRequest request,
                               HttpServletResponse response,
                               Integer id,
                               String nickname,
                               String password,
                               Integer sex,
                               String mobile,
                               Integer cityId) {
        try {
            User user = userService.getById(id);
            user.setNickname(nickname);
            user.setPassword(MD5Util.encodeByMD5(password));
            user.setSex(sex);
            user.setMobile(mobile);
            user.setCity(cityService.getById(cityId));
            if(user.getHeadImage()==null){
                user.setHeadImage("static/images/defaultPhoto.png");
            }
            userService.update(user);
            WebUtil.print(response, new Result(true).msg("会员信息修改成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("会员信息修改失败！"));
        }
    }
}

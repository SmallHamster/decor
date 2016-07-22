package com.bluemobi.decor.portal.controller.background;

import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.service.LoginService;
import com.bluemobi.decor.portal.util.CookiesUtils;
import com.bluemobi.decor.portal.util.MD5Util;
import com.bluemobi.decor.service.MessageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by liuhm on 2015/7/24.
 */

@Controller
@RequestMapping(value = "/backend")
public class LoginController extends CommonController {
    @Autowired
    private LoginService loginService;

    @Autowired
    private MessageService messageService;

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
        Boolean success = loginService.backendLogin(username, MD5Util.encodeByMD5(password));
        if (success) {
            // 登录成功后，将用户名放入cookies
            if (StringUtils.isNotEmpty(remark)) {
                int loginMaxAge = 30 * 24 * 60 * 60; // 定义cookies的生命周期，这里是一个月。单位为秒
                CookiesUtils.addCookie(response, "name", username, loginMaxAge);
            } else {
                CookiesUtils.delCookie(response, "name");
            }
            Message message = messageService.showToMain();
            model.put("message", message);
            return "首页";
        } else {
            model.addAttribute("error", "用户名或密码错误!");
            return "登录";
        }
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        loginService.backendLogOut(request);
        return "redirect:/backend/login";
    }

    @RequestMapping(value = "/login/home")
    public String dashboard(ModelMap model) {
        Message message = messageService.showToMain();
        model.put("message", message);
        return "首页";
    }
}

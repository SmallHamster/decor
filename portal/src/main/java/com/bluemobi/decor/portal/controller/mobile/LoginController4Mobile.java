package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.MD5Util;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value = "/mobile/login")
public class LoginController4Mobile extends CommonController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/loginPage")
    public String loginPage(ModelMap modelMap,
                     HttpServletRequest request){
        return "mobile/login";
    }

    // 登录
    @RequestMapping(value = "/login")
    public void login(HttpServletRequest request,
                      HttpServletResponse response,
                      String username,
                      String password,String remark) {
        try {
            password = MD5Util.encodeByMD5(password);
            User user = userService.mobileLogin(username, password);
            if (user != null) {
                WebUtil.print(response, new Result(true).data(user));
            } else {
                WebUtil.print(response, new Result(false).msg("用户名或密码错误!"));
            }
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

}

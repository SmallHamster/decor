package com.bluemobi.decor.portal.controller;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.util.CookiesUtils;
import com.bluemobi.decor.portal.util.SessionUtils;
import com.bluemobi.decor.service.MessageService;
import com.bluemobi.decor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;
import java.util.Map;


@Controller
public class IndexController {

    @Autowired
    private MessageService messageService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/backend")
    public String adminHomepage() {
        return "登录";
    }

    @RequestMapping(value = "/")
    public String pcHomepage() {
        return "redirect:index";
    }

    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request,
                        ModelMap model, String langua) {
        if (langua != null) {
            SessionUtils.put("langua", langua);
        }else{
            SessionUtils.put("langua", "zh_CN");
        }
        Message message = messageService.showToMainPC();
        model.put("message", message);

        Map<String,Object> map = CookiesUtils.ReadCookieMap(request);
        if(map.get("userId") != null){
            User user = userService.getById(Integer.parseInt(map.get("userId").toString()));
            String nickname = user.getNickname();
            String shortNickname = nickname;
            if (nickname != null && nickname.length() > 4) {
                shortNickname = nickname.substring(0, 4) + "...";
            }
            user.setShortNickname(shortNickname);
            SessionUtils.put(Constant.SESSION_PC_USER, user);
        }

        return "pc/首页";
    }

}

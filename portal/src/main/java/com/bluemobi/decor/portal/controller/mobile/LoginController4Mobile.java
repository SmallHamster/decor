package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.portal.controller.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/mobile/login")
public class LoginController4Mobile extends CommonController {

    @RequestMapping(value = "/loginPage")
    public String loginPage(ModelMap modelMap,
                     HttpServletRequest request){
        return "mobile/login";
    }

}

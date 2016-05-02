package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.portal.controller.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/mobile/designer")
public class DesignerController4Mobile extends CommonController {



    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                     HttpServletRequest request){
        return "mobile/designer_detail";
    }

}

package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.portal.controller.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping(value = "/mobile/forward")
public class ForwardController4Mobile extends CommonController {

    @RequestMapping(value = "/to")
    public String to(ModelMap modelMap,
                        HttpServletRequest request,
                        String type,
                        String name){
        try {
            modelMap.put("name",name);
            modelMap.put("type",type);
            if("goods".equals(type)){
                return "mobile/goods_list";
            }else if("scene".equals(type)){
                return "mobile/scene_list";
            }else if("series".equals(type)){
                return "mobile/series_list";
            }else if("designer".equals(type)){
                return "mobile/designer_list";
            }else if("message".equals(type)){
                return "mobile/message_list";
            }else if("index".equals(type)){
                return "mobile/index";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "pc/商品图列表";
    }


}

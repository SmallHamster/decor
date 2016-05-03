package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.service.UserService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
@RequestMapping(value = "/mobile/forward")
public class ForwardController4Mobile extends CommonController {
    @Autowired
    private UserService userService;

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
                List<User> userList = userService.allUser();
                modelMap.put("designerNum", CollectionUtils.isEmpty(userList)?0:userList.size());
                return "mobile/index";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "pc/商品图列表";
    }


}

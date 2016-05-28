package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.Ad;
import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.entity.Scene;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.AdService;
import com.bluemobi.decor.service.MessageService;
import com.bluemobi.decor.service.SceneService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * 查询调整
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/pc/forward")
public class ForwardController4Pc extends CommonController {

    @RequestMapping(value = "/to")
    public String to(ModelMap modelMap,
                        HttpServletRequest request,
                        String type,
                        String name,
                     String kindTagId,
                     String spaceTagId,
                     String styleTagId){
        try {
//            if(name!=null){
//                name = java.net.URLDecoder.decode(name, "UTF-8");
//            }
            modelMap.put("name",name);
            modelMap.put("type",type);
            if("goods".equals(type)){
                if(StringUtils.isBlank(kindTagId)){
                    kindTagId = "";
                }
                if(StringUtils.isBlank(spaceTagId)){
                    spaceTagId = "";
                }
                if(StringUtils.isBlank(styleTagId)){
                    styleTagId = "";
                }
                modelMap.put("kindTagId",kindTagId);
                modelMap.put("spaceTagId",spaceTagId);
                modelMap.put("styleTagId",styleTagId);
                return "pc/商品图列表";
            }else if("scene".equals(type)){
                return "pc/场景图列表";
            }else if("series".equals(type)){
                return "pc/系列图列表";
            }else if("user".equals(type)){
                return "pc/设计师列表";
            }else if("message".equals(type)){
                return "pc/资讯列表";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "pc/商品图列表";
    }
    @RequestMapping(value = "/aboutWeb")
    public String aboutWeb(ModelMap modelMap,
                     HttpServletRequest request){

        return "pc/关于网站";
    }


}

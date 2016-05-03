package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.Goods;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.GoodsService;
import com.bluemobi.decor.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
@RequestMapping(value = "/mobile/designer")
public class DesignerController4Mobile extends CommonController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/detail")
    public String detail(ModelMap modelMap,
                     HttpServletRequest request){
        return "mobile/designer_detail";
    }

    //用户分页
    @RequestMapping(value = "/page")
    public void page(HttpServletRequest request, HttpServletResponse response, Integer pageNum,
                              Integer pageSize, Integer cityId, String name, Integer provinceId, String sort) {
        try {
            if (pageNum == null) {
                pageNum = 1;
            }
            if (pageSize == null) {
                pageSize = 2;
            }
            Page<User> page = userService.pcPage(pageNum, pageSize, null, "fans", name, null);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }
}

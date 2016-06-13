package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.AboutWeb;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.AboutWebService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 背景图
 */
@Controller
@RequestMapping(value = "/pc/aboutWeb")
public class AboutWebController4Pc extends CommonController {
    @Autowired
    private AboutWebService aboutWebService;

    @RequestMapping(value = "/all")
    public void all(HttpServletResponse response){
        try {
            List<AboutWeb> list = aboutWebService.all();
            WebUtil.print(response, new Result(true).data(list));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新页面后重试!"));
        }
    }

}

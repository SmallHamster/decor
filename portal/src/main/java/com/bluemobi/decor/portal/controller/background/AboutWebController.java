package com.bluemobi.decor.portal.controller.background;

import com.bluemobi.decor.common.factory.DataTableFactory;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.AboutWeb;
import com.bluemobi.decor.entity.Feedback;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.AboutWebService;
import com.bluemobi.decor.service.FeedbackService;
import com.bluemobi.decor.utils.ComFun;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 关于网站管理
 * Created by tuyh on 2015/7/23
 */
@Controller
@RequestMapping(value = "/backend/aboutweb")
public class AboutWebController extends CommonController {
    @Autowired
    private AboutWebService aboutWebService;

    @RequestMapping(value = "/index")
    public String index() {
        
        return "关于网站";
    }

    @RequestMapping(value = "/list")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer draw,
                     Integer start,
                     Integer length,
                     String title) {
        try {
            int pageNum = getPageNum(start, length);
            Page<AboutWeb> page = aboutWebService.pageWithTitle(pageNum, length, title);
            Map<String, Object> result = DataTableFactory.fitting(draw, page);
            WebUtil.print(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/shows")
    public String shows(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer id,
                     ModelMap model) {
        AboutWeb aboutWeb = aboutWebService.getById(id);
        model.put("aboutWeb", aboutWeb);
        return "查看关于网站";
    }

    @RequestMapping(value = "/updateWebInfo")
    public void updateWebInfo(HttpServletRequest request,
                                  HttpServletResponse response,
                                  Integer id) {
        try {
            String str = request.getParameter("content");

            AboutWeb aboutWeb = aboutWebService.getById(id);
            aboutWeb.setContent(str);

            aboutWebService.update(aboutWeb);
            WebUtil.print(response, new Result(true).msg("网站信息修改成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("网站信息修改失败！"));
        }
    }
}
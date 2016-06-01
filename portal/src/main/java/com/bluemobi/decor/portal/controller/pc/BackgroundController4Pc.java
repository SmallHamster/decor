package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.Background;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.BackgroundService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 背景图
 */
@Controller
@RequestMapping(value = "/pc/background")
public class BackgroundController4Pc extends CommonController {
    @Autowired
    private BackgroundService backgroundService;

    // 分页查询
    @RequestMapping(value = "/page")
    public void pageMyCollection(HttpServletResponse response,
                     Integer pageNum,
                     Integer pageSize){
        try {
            if(pageNum == null){
                pageNum = 1;
            }
            if(pageSize == null){
                pageSize = 12;
            }
            Page<Background> page = backgroundService.page(
                    pageNum, pageSize);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新页面后重试!"));
        }
    }

}

package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.KindTag;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.PcPageFactory;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.KindTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
@RequestMapping(value = "/pc/kindTag")
public class KindTagController4Pc extends CommonController {
    @Autowired
    private KindTagService kindTagService;

    @RequestMapping(value = "/page")
    public void page(HttpServletResponse response,
                     Integer pageNum,
                     Integer pageSize,
                     String name){
        try {
            if(pageNum == null){
                pageNum = 1;
            }
            if(pageSize == null){
                pageSize = 20;
            }
            Page<KindTag> page = kindTagService.page(pageNum, pageSize,name);
            Map<String, Object> dataMap = PcPageFactory.fitting(page);
            WebUtil.print(response, new Result(true).data(dataMap));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新页面后重试!"));
        }
    }

}

package com.bluemobi.decor.portal.controller.mobile;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.MessageService;
import com.bluemobi.decor.service.UserService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 首页
 * Created by gaoll on 2015/3/3.
 */
@Controller
@RequestMapping(value = "/mobile/homepage")
public class HomepageController4Mobile extends CommonController {

    @Autowired
    private UserService userService;
    @Autowired
    private MessageService messageService;


    // 首页显示两位设计师
    @RequestMapping(value = "/ajaxDesigner")
    public void ajaxDesigner(HttpServletRequest request,
                                     HttpServletResponse response) {
        try {
            List<User> userList = userService.maxFans();
            List<User> newList = new ArrayList<User>();
            if(CollectionUtils.isNotEmpty(userList)){
                for (int i = 0; i < userList.size(); i++) {
                    if(i <= 1){
                        newList.add(userList.get(i));
                    }
                }
            }
            WebUtil.print(response, new Result(true).data(newList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }

    // ajax查询推荐的咨询
    @RequestMapping(value = "/ajaxRecommendMessage")
    public void ajaxRecommendMessage(HttpServletRequest request,
                                     HttpServletResponse response) {
        try {
            List<Message> adList = messageService.pcRecommendList();
            WebUtil.print(response, new Result(true).data(adList));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败!"));
        }
    }


}

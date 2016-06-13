package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.entity.UserThird;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.UserThirdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.List;


@Controller
@RequestMapping(value = "/pc/userThird")
public class UserThirdController4Pc extends CommonController {
    @Autowired
    private UserThirdService userThirdService;

    @RequestMapping(value = "/findInfo")
    public void all(HttpServletResponse response,Integer userId){
        try {
            User user = new User();
            user.setId(userId);
            List<UserThird> list = userThirdService.iFindUserThirdWithUser(user);
            WebUtil.print(response, new Result(true).data(list));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新页面后重试!"));
        }
    }

}

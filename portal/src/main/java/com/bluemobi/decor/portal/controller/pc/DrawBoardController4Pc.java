package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.portal.controller.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/pc/drawBoard")
public class DrawBoardController4Pc extends CommonController {

    @RequestMapping(value = "/page")
    public String page(){
        return "pc/drawBoard";
    }






}

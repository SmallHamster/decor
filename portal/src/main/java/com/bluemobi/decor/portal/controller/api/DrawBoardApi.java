package com.bluemobi.decor.portal.controller.api;

import com.bluemobi.decor.core.ERROR_CODE;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.DrawBoard;
import com.bluemobi.decor.portal.util.UploadUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.DrawBoardService;
import com.bluemobi.decor.utils.APIFactory;
import com.bluemobi.decor.utils.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 画板作品
 * Created by tuyh on 2015/7/13.
 */
@Controller
@RequestMapping("api/drawboard")
public class DrawBoardApi {

    @Autowired
    private DrawBoardService drawBoardService;

    /**
     * 新增画板
     * by gaolei
     */
    @RequestMapping(value = "/save")
    public void addGoodsInfo(HttpServletRequest request,
                             HttpServletResponse response,
                             Integer userId,
                             @RequestParam(required = false) MultipartFile file) {
        String image = UploadUtils.uploadMultipartFile(file);
        drawBoardService.save(userId, image);
        WebUtil.printApi(response, new Result(true));
    }

    // 我的画板作品列表（分页）
    @RequestMapping(value = "/findMySketchpadList")
    public void findMyCollection(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Integer pageNum,
                                 Integer pageSize,
                                 Integer userId) {
        if (null == userId || null == pageNum || null == pageSize) {
            WebUtil.printApi(response, new Result(false).msg(ERROR_CODE.ERROR_CODE_0002));
            return;
        }

        Page<DrawBoard> page = drawBoardService.iPageWithUser(userId, pageNum, pageSize);

        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = null;
        for (DrawBoard drawBoard : page.getContent()) {
            map = new HashMap<String, Object>();
            map.put("id", drawBoard.getId());
            map.put("path", drawBoard.getImage());
            list.add(map);
        }

        Map<String, Object> dataMap = APIFactory.fitting(page, list);
        Result obj = new Result(true).data(dataMap);
        String result = JsonUtil.obj2ApiJson(obj, "name");
        WebUtil.printApi(response, result);
    }

    // 画板页面图片列表：6张场景图，6张素材图。
    // 都先查询自己的，如果不足6条则再查询推荐的，补足6条即可
    @RequestMapping(value = "/imageData")
    public void imageData(HttpServletRequest request,
                          HttpServletResponse response,
                          Integer userId) {
        if (null == userId) {
            WebUtil.printApi(response, new Result(false).msg(ERROR_CODE.ERROR_CODE_0002));
            return;
        }

        Map<String, Object> map = drawBoardService.iImageData(userId);
        if (map == null) {
            map = new HashMap<>();
        }
        Result obj = new Result(true).data(map);
        String result = JsonUtil.obj2ApiJson(obj, "user");
        WebUtil.printApi(response, result);
    }
}

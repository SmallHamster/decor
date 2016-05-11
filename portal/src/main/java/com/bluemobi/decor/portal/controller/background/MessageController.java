package com.bluemobi.decor.portal.controller.background;


import com.bluemobi.decor.common.factory.DataTableFactory;
import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.Message;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.UploadUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.MessageService;
import com.bluemobi.decor.service.MessageTagService;
import com.bluemobi.decor.utils.ComFun;
import com.bluemobi.decor.utils.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * message管理
 * Created by tuyh on 2015/7/20.
 */
@Controller
@RequestMapping(value = "/backend/message")
public class MessageController extends CommonController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private MessageTagService messageTagService;

    @RequestMapping(value = "/index")
    public String index() {
        return "资讯列表";
    }

    @RequestMapping(value = "/add")
    public String add() {
        return "添加资讯";
    }

    @RequestMapping(value = "/list")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer draw,
                     Integer start,
                     Integer length,
                     Integer tagId,
                     String title) {
        try {
            int pageNum = getPageNum(start, length);
            Page<Message> page = messageService.findMessagePage(tagId, title, pageNum, length);
            for (Message message : page.getContent()) {
                message.setTagName(message.getMessageTag().getName());
            }
            Map<String, Object> result = DataTableFactory.fitting(draw, page);
            WebUtil.print(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/batchDelete")
    public void batchDelete(HttpServletRequest request,
                            HttpServletResponse response,
                            String ids) {
        try {
            int[] arrayId = JsonUtil.json2Obj(ids, int[].class);
            messageService.deleteAll(arrayId);
            WebUtil.print(response, new Result(true).msg("批量删除资讯成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("批量删除资讯失败！"));
        }
    }

    @RequestMapping(value = "/delete")
    public void delete(HttpServletRequest request,
                       HttpServletResponse response,
                       Integer id) {
        try {
            messageService.deleteById(id);
            WebUtil.print(response, new Result(true).msg("资讯删除成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("资讯删除失败！"));
        }
    }

    @RequestMapping("/changeRecommend")
    public void changeRecommend(HttpServletRequest request,
                                HttpServletResponse response,
                                Integer id,
                                String isRecommend) {
        String msg = "";
        if (isRecommend.equals("yes")) {
            msg = "推荐";
        } else {
            msg = "取消推荐";
        }
        try {
            messageService.changeRecommend(id, isRecommend);
            WebUtil.print(response, new Result(true).msg(msg + "成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg(msg + "失败！"));
        }
    }

    @RequestMapping(value = "/shows")
    public String shows(HttpServletRequest request,
                        HttpServletResponse response,
                        Integer id,
                        ModelMap model) {
        Message message = messageService.getById(id);
        model.put("message", message);
        model.put("messageTagId", message.getMessageTag().getId());
        model.put("messageTags", ComFun.tagsThin(message.getShowTags()) + ",");

        return "编辑资讯";
    }

    @RequestMapping(value = "/showToMain")
    public void showToMain(HttpServletRequest request,
                                          HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        Message message = messageService.showToMain();
        if (null != message) {
            map.put("id", message.getId());
            map.put("title", message.getTitle());
            map.put("createTime", message.getCreateTime());
            map.put("subContent", message.getSubContent());
        }

        WebUtil.print(response, map);
    }

    @RequestMapping(value = "/addMessageInfo")
    public void addMessageInfo(HttpServletRequest request,
                               HttpServletResponse response,
                               String image,
                               Integer tagId,
                               String title,
                               Integer showTurn,
                               String tags,
                               String subContent,
                               String intro_image) {
        try {
            String str = request.getParameter("content");
            Message message = new Message();
            message.setTitle(title);
            message.setMessageTag(messageTagService.getById(tagId));
            message.setShowTurn(showTurn);
            if (message.getCollectionNum()==null){
                message.setCollectionNum(0);
            }
            if (null != image) {
                message.setImage(image);
            } else {
                WebUtil.print(response, new Result(false).msg("封面图片不能为空！"));
            }
            if (null!=intro_image){
                message.setIntro_image(intro_image);
            }else {
                WebUtil.print(response, new Result(false).msg("资讯图片不能为空！"));
            }
            message.setContent(str);
            // 为tag添加的@
            message.setShowTags(ComFun.tagsFat(tags));
            message.setIsRecommend(Constant.USER_INFO_IsRECOMMEND_NO);
            message.setCreateTime(new Date());
            System.out.println(subContent);
            message.setSubContent(subContent.trim());

            messageService.create(message);
            WebUtil.print(response, new Result(true).msg("资讯信息添加成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("资讯信息添加失败！"));
        }
    }

    @RequestMapping(value = "/updateMessageInfo")
    public void updateMessageInfo(HttpServletRequest request,
                                  HttpServletResponse response,
                                  String image,
                                  Integer id,
                                  Integer tagId,
                                  String title,
                                  Integer showTurn,
                                  String tags,
                                  String subContent,
                                  String intro_image) {
        try {
            String str = request.getParameter("content");
            Message message = messageService.getById(id);
            message.setTitle(title);
            message.setMessageTag(messageTagService.getById(tagId));
            message.setShowTurn(showTurn);
            if (message.getCollectionNum()==null){
                 message.setCollectionNum(0);
            }
            if (null != image) {
                // 如果有新图片传入，则删除旧图片
                // UploadUtils.deleteFile(message.getImage());

                message.setImage(image);
            }
            if (null != intro_image) {
                // 如果有新图片传入，则删除旧图片
                // UploadUtils.deleteFile(message.getIntro_image());

                message.setIntro_image(intro_image);
            }
            message.setContent(str);
            message.setSubContent(subContent.trim());
            // 为tag添加的@
            message.setShowTags(ComFun.tagsFat(tags));

            messageService.update(message);
            WebUtil.print(response, new Result(true).msg("资讯信息修改成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("资讯信息修改失败！"));
        }
    }
}

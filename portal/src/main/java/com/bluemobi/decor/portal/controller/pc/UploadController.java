package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.UploadUtils;
import com.bluemobi.decor.service.DrawBoardService;
import com.bluemobi.decor.service.UploadImageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 上传
 */
@Controller
@RequestMapping(value = "/pc/upload")
public class UploadController extends CommonController {

    @Autowired
    private UploadImageService uploadImageService;
    @Autowired
    private DrawBoardService drawBoardService;


    @RequestMapping(value = "/uploadImageToQiniu")
    @ResponseBody
    public Map<String,Object> saveImage(HttpServletRequest request,
                            HttpServletResponse response,
                            @RequestParam(required = false) MultipartFile file) {
        String image = "";
        String thumbnailImage = "";
        if (file != null) {
            image = UploadUtils.uploadMultipartFile(file);
            thumbnailImage = uploadImageService.uploadThumbImage2Qiniu(file);
        }

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("image",image);
        map.put("thumbnailImage",thumbnailImage);
        return map;
    }

    // 上传base64图片
    @RequestMapping(value = "/uploadBase64ImageToQiniu")
    @ResponseBody
    public Result uploadBase64ImageToQiniu(HttpServletRequest request,
                                           HttpServletResponse response,Integer userId) {
        String image = request.getParameter("image");
        String header = "data:image/png;base64,";
        image = image.substring(header.length());
        try {
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] decodedBytes = decoder.decodeBuffer(image);
            String imgFilePath = getFilePath();
            FileOutputStream out = new FileOutputStream(imgFilePath);
            // 文件上传到本地
            out.write(decodedBytes);
            out.close();
            File file = new File(imgFilePath);
            // 上传到七牛
            String qiniuPath = UploadUtils.uploadFile(file);
            if(StringUtils.isBlank(qiniuPath)){
                return new Result(false).msg("系统异常，请刷新后重试！");
            }
            if(userId == null){
                return new Result(false).msg("用户身份失效，请刷新后重试！");
            }
            // 保存到数据库
            drawBoardService.save(userId,qiniuPath);
            return new Result(true);
        } catch (IOException e) {
            e.printStackTrace();
            return new Result(false).msg("系统异常，请刷新后重试！");
        }
    }

    public String getFilePath(){
        String filePath = "drawBoardUploadFile/" + System.currentTimeMillis() + "png";
        String projectPath = UploadController.class.getResource("/").getPath();
        return projectPath.substring(0,projectPath.indexOf("WEB-INF")) + filePath;
    }


}
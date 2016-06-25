package com.bluemobi.decor.portal.controller.pc;

import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.UploadUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.service.DrawBoardService;
import com.bluemobi.decor.service.SceneService;
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
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
    @Autowired
    private SceneService sceneService;


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
    public void uploadBase64ImageToQiniu(HttpServletRequest request,
                                           HttpServletResponse response,Integer userId,String path,
                                         String sceneName,
                                         String styleTagIds,
                                         String spaceTagIds,
                                         String info,
                                         String isShow) {
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
                WebUtil.print(response, new Result(false).msg("系统异常，请刷新后重试！"));
            }
            if(userId == null){
                WebUtil.print(response, new Result(false).msg("用户身份失效，请刷新后重试！"));
            }
            // 保存到数据库
            drawBoardService.save(userId,qiniuPath);
            // 保存到场景
            sceneService.insert(userId, sceneName, styleTagIds, spaceTagIds, info, qiniuPath,
                    isShow, "yes", new ArrayList<Map<String, Object>>());

            // 删除本地文件
            try {
                if(file.isFile() && file.exists()){
                    file.delete();
                }
            }catch (Exception Ec){
                // do nothing
            }
            // 删除临时文件
            if(StringUtils.isNotBlank(path)){
                String[] pathArr = path.trim().split("@@@@@");
                for(String p : pathArr){
                    String localPath = getLocalPath() + p;
                    File tempFile = new File(localPath);
                    try {
                        if(tempFile.isFile() && tempFile.exists()){
                            tempFile.delete();
                        }
                    }catch (Exception Ec){
                        // do nothing
                    }
                }
            }

            WebUtil.print(response, new Result(true));
        } catch (IOException e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新后重试！"));
        }
    }

    public String getFilePath(){
        String filePath = "drawBoardUploadFile/" + System.currentTimeMillis() + ".png";
        String projectPath = UploadController.class.getResource("/").getPath();
        return projectPath.substring(0,projectPath.indexOf("WEB-INF")) + filePath;
    }

    public String getLocalPath(){
        String projectPath = UploadController.class.getResource("/").getPath();
        return projectPath.substring(0,projectPath.indexOf("WEB-INF"));
    }

    @RequestMapping(value = "/chanceQiniuPathToLocal")
    public void chanceQiniuPathToLocal(HttpServletRequest request,
                                         HttpServletResponse response,String path) {
        try {
            if(StringUtils.isBlank(path)){
                WebUtil.print(response, new Result(true).data(""));
            }else {
                String[] pathArr = path.trim().split("@@@@@");
                List<String> list = new ArrayList<String>();
                for(String p : pathArr){
                    String tempPath = "static/changePathArea/" + System.currentTimeMillis() + ".png";
                    String localPath = getLocalPath() + tempPath;
                    download(p,localPath);
                    list.add(tempPath);
                }
                WebUtil.print(response, new Result(true).data(list));
            }
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新后重试！"));
        }
    }

    public void download(String urlString, String filename){
        try {
            URL url = new URL(urlString);
            URLConnection con = url.openConnection();
            // 输入流
            InputStream is = con.getInputStream();
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流
            OutputStream os = new FileOutputStream(filename);
            // 开始读取
            while ((len = is.read(bs)) != -1) {
                os.write(bs, 0, len);
            }
            // 完毕，关闭所有链接
            os.close();
            is.close();
        }  catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/uploadUeditorImageToQiniu")
    public void uploadUeditorImageToQiniu(HttpServletRequest request,
                                         HttpServletResponse response,String path) {
        try {
            if(path.contains("http://121.40.54.152")){
                path = path.replace("http://121.40.54.152","");
                File file = new File(getLocalPath() + path);
                // 上传到七牛
                String qiniuPath = UploadUtils.uploadFile(file);
                if(StringUtils.isBlank(qiniuPath)){
                    WebUtil.print(response, new Result(false).msg("系统异常，请刷新后重试！"));
                    return;
                }else {
                    // 删除本地文件
                    try {
                        if(file.isFile() && file.exists()){
                            file.delete();
                        }
                    }catch (Exception Ec){
                        // do nothing
                    }
                    WebUtil.print(response, new Result(true).data(qiniuPath));
                }
            }
            WebUtil.print(response, new Result(true));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg("系统异常，请刷新后重试！"));
        }
    }
}
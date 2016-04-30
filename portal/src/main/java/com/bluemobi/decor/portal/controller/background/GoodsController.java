package com.bluemobi.decor.portal.controller.background;

import com.bluemobi.decor.common.factory.DataTableFactory;
import com.bluemobi.decor.core.bean.Result;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.portal.controller.CommonController;
import com.bluemobi.decor.portal.util.SessionUtils;
import com.bluemobi.decor.portal.util.UploadUtils;
import com.bluemobi.decor.portal.util.WebUtil;
import com.bluemobi.decor.portal.util.ZipUtil;
import com.bluemobi.decor.service.*;
import com.bluemobi.decor.utils.ComFun;
import com.bluemobi.decor.utils.ExcelUtil;
import com.bluemobi.decor.utils.FileUtil;
import com.bluemobi.decor.utils.JsonUtil;
import net.sf.json.JSONArray;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * 商品图Controller
 * Created by reny on 2015/7/20.
 */
@Controller
@RequestMapping(value = "/backend/goods")
public class GoodsController extends CommonController {
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private GoodsImageService goodsImageService;
    @Autowired
    private KindTagService kindTagService;
    @Autowired
    private SpaceTagService spaceTagService;
    @Autowired
    private StyleTagService styleTagService;
    @Autowired
    private MaterialService materialService;

    @RequestMapping(value = "/index")
    public String index() {
        return "商品图列表";
    }

    /**
     * 分页获取商品图片列表
     */
    @RequestMapping(value = "/list")
    public void list(HttpServletRequest request,
                     HttpServletResponse response,
                     Integer draw,
                     Integer start,
                     Integer length,
                     Integer id, String goodsName,
                     Integer kindTagId, String isPass,
                     String styleId, String spaceId,
                     ModelMap model) {

        try {
            int pageNum = getPageNum(start, length);
            Page<Goods> page = goodsService.findGoods(id, goodsName, kindTagId, styleId, spaceId, isPass, pageNum, length);
            for (Goods goods : page.getContent()) {
                KindTag kindTag = null;
                if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
                    kindTag = kindTagService.getById(Integer.parseInt(ComFun.tagsThin(goods.getKindTagIds())));
                } else {
                    goods.setKindTagName("暂无类别");
                }
                if (kindTag != null) {
                    goods.setKindTagName(kindTag.getName());
                } else {
                    goods.setKindTagName("数据问题");
                }

                //空间标签名称的集合
                List<String> spaceTagNames = new ArrayList<String>();
                //获取空间标签
                String spTagIdsT = goods.getSpaceTagIds();
                if (StringUtils.isNotEmpty(spTagIdsT)) {
                    //把@1@,@2@,@3@类型的ids转换成1,2,3
                    List<Integer> tagIds = ComFun.tagsToList(goods.getSpaceTagIds());
                    //循环给tagNames集合添加标签名称
                    for (Integer tagId : tagIds) {
                        SpaceTag spaceTag = spaceTagService.getById(tagId);
                        if (spaceTag != null) {
                            spaceTagNames.add(spaceTag.getName());
                        } else {
                            spaceTagNames.add("数据问题");
                        }
                    }
                } else {
                    spaceTagNames.add("暂无空间标签");
                }
                goods.setSpaceTagName(spaceTagNames);

                //风格标签名称的集合
                List<String> styleTagNames = new ArrayList<String>();
                //获取空间标签
                String stTagIdsT = goods.getStyleTagIds();
                if (StringUtils.isNotEmpty(stTagIdsT)) {
                    //把@1@,@2@,@3@类型的ids转换成1,2,3
                    List<Integer> tagIds = ComFun.tagsToList(goods.getStyleTagIds());
                    //循环给tagNames集合添加标签名称
                    for (Integer tagId : tagIds) {
                        StyleTag styleTag = styleTagService.getById(tagId);
                        if (styleTag != null) {
                            styleTagNames.add(styleTag.getName());
                        } else {
                            styleTagNames.add("数据问题");
                        }
                    }
                } else {
                    styleTagNames.add("暂无风格标签");
                }
                goods.setStyleTagName(styleTagNames);
            }
            Map<String, Object> result = DataTableFactory.fitting(draw, page);
            WebUtil.print(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 分页获取商品图片列表
     */
    @RequestMapping(value = "/findGoods", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> findGoods(HttpServletRequest request,
                                         HttpServletResponse response, String goodsName,
                                         String styleId, String spaceId, Integer pageNum) {
        if (pageNum == null) {
            pageNum = 1;
        }

        //商品图片集合
        List<Map<String, Object>> goodsImageList = new ArrayList<Map<String, Object>>();
        Page<Goods> page = goodsService.findGoods(null, goodsName, null, styleId, spaceId, null, pageNum, 9);
        //总页数
        int totalPage = page.getTotalPages();
        if (pageNum > totalPage) {
            page = goodsService.findGoods(null, goodsName, null, styleId, spaceId, null, 1, 9);
            pageNum = 1;
        }
        for (Goods goods : page.getContent()) {
            Map<String, Object> goodsImage = new HashMap<String, Object>();
            goodsImage.put("goodsId", goods.getId());
            goodsImage.put("goodsImage", goods.getCover());
            goodsImageList.add(goodsImage);
        }

        //分页信息
        List<Map<String, Object>> pageInfos = new ArrayList<Map<String, Object>>();
        //初始化跳转到第一页
        Map<String, Object> pageFrist = new HashMap<String, Object>();
        pageFrist.put("pageNum", 1);
        pageInfos.add(pageFrist);
        int index = 0;
        if (totalPage < 10) {
            index = totalPage - 2;
        } else {
            index = 10 - 2;
        }
        for (int i = 0; i < index; i++) {//除去首页尾页，只显示8个数字
            Map<String, Object> pageinfo = new HashMap<String, Object>();
            int indexPageNum = 1;
            if (pageNum > totalPage - 7) {
                indexPageNum = totalPage - index + i;
            } else if (pageNum - 8 <= 1) {
                indexPageNum = i + 2;
            } else {
                indexPageNum = pageNum + i;
            }
            pageinfo.put("pageNum", indexPageNum);
            pageInfos.add(pageinfo);
        }
        //初始化跳转到尾页
        Map<String, Object> pageLast = new HashMap<String, Object>();
        if (totalPage != 1) {
            pageLast.put("pageNum", totalPage);
        }
        pageInfos.add(pageLast);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("goodsImageList", goodsImageList);
        map.put("pageInfos", pageInfos);
        map.put("totalPage", totalPage);
        return map;
    }

    /**
     * 分页获取商品图片列表
     */
    @RequestMapping(value = "/listToMain")
    public void listToMain(HttpServletRequest request,
                           HttpServletResponse response) {

        try {
            Page<Goods> page = goodsService.pageToMain(1, 3);
            for (Goods goods : page.getContent()) {
                KindTag kindTag = null;
                if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
                    kindTag = kindTagService.getById(Integer.parseInt(ComFun.tagsThin(goods.getKindTagIds())));
                } else {
                    goods.setKindTagName("暂无类别");
                }
                if (kindTag != null) {
                    goods.setKindTagName(kindTag.getName());
                } else {
                    goods.setKindTagName("数据问题");
                }
            }
            Map<String, Object> result = DataTableFactory.fitting(1, page);
            WebUtil.print(response, result);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 商品图详情页
     */
    @RequestMapping(value = "/shows")
    public String shows(HttpServletRequest request,
                        HttpServletResponse response,
                        Integer id,
                        ModelMap model) {
        Goods goods = goodsService.getById(id);

        KindTag kindTag = null;
        if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
            kindTag = kindTagService.getById(Integer.parseInt(ComFun.tagsThin(goods.getKindTagIds())));
        } else {
            goods.setKindTagName("暂无类别");
        }
        if (kindTag != null) {
            goods.setKindTagName(kindTag.getName());
        } else {
            goods.setKindTagName("数据问题");
        }

        //空间标签名称的集合
        List<String> spaceTagNames = new ArrayList<String>();
        //获取空间标签
        String spTagIdsT = goods.getSpaceTagIds();
        if (StringUtils.isNotEmpty(spTagIdsT)) {
            //把@1@,@2@,@3@类型的ids转换成1,2,3
            List<Integer> tagIds = ComFun.tagsToList(goods.getSpaceTagIds());
            //循环给tagNames集合添加标签名称
            for (Integer tagId : tagIds) {
                SpaceTag spaceTag = spaceTagService.getById(tagId);
                if (spaceTag != null) {
                    spaceTagNames.add(spaceTag.getName());
                } else {
                    spaceTagNames.add("数据问题");
                }
            }
        } else {
            spaceTagNames.add("暂无空间标签");
        }
        goods.setSpaceTagName(spaceTagNames);

        //风格标签名称的集合
        List<String> styleTagNames = new ArrayList<String>();
        //获取空间标签
        String stTagIdsT = goods.getStyleTagIds();
        if (StringUtils.isNotEmpty(stTagIdsT)) {
            //把@1@,@2@,@3@类型的ids转换成1,2,3
            List<Integer> tagIds = ComFun.tagsToList(goods.getStyleTagIds());
            //循环给tagNames集合添加标签名称
            for (Integer tagId : tagIds) {
                StyleTag styleTag = styleTagService.getById(tagId);
                if (styleTag != null) {
                    styleTagNames.add(styleTag.getName());
                } else {
                    styleTagNames.add("数据问题");
                }
            }
        } else {
            styleTagNames.add("暂无风格标签");
        }
        goods.setStyleTagName(styleTagNames);

        List<GoodsImage> goodsImages = goodsImageService.listByGoodsId(goods.getId());
        List<Map<String, Object>> imagePlusList = new ArrayList<Map<String, Object>>();
        Map<String, Object> imgMap = null;
        if (null != goodsImages && goodsImages.size() > 0) {
            for (GoodsImage goodsImage : goodsImages) {
                // 拼接返回值
                imgMap = new HashMap<String, Object>();
                if (StringUtils.equals(goodsImage.getImage(), goods.getCover())) {
                    imgMap.put("isCover", "1");
                } else {
                    imgMap.put("isCover", "0");
                }
                if (StringUtils.equals(goodsImage.getIsTurnMaterial(), "yes")) {
                    imgMap.put("isMaterial", "1");
                } else {
                    imgMap.put("isMaterial", "0");
                }
                imgMap.put("path", goodsImage.getImage());
                // 组合返回值
                imagePlusList.add(imgMap);
            }
        }
        model.put("goods", goods);
        model.put("imageList", JSONArray.fromObject(imagePlusList.size() == 0 ? new ArrayList<Map<String, Object>>() : imagePlusList));
        return "查看商品图";
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
            goodsService.changeRecommend(id, isRecommend);
            WebUtil.print(response, new Result(true).msg(msg + "成功！"));
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.print(response, new Result(false).msg(msg + "失败！"));
        }
    }

    /**
     * 审核通过商品图片
     */
    @RequestMapping(value = "/examineYes")
    public void examineYes(HttpServletRequest request,
                           HttpServletResponse response,
                           Integer id) {
        Goods goods = goodsService.getById(id);
        if (goods == null) {
            WebUtil.print(response, new Result(false).msg("抱歉，数据错误！"));
            return;
        }
        if (StringUtils.equals("yes", goods.getIsPass())) {
            WebUtil.print(response, new Result(false).msg("该图片已是通过状态，请勿重复操作！"));
            return;
        }
        try {
            goods.setIsPass("yes");
            goodsService.update(goods);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    /**
     * 审核不通过商品图片
     */
    @RequestMapping(value = "/examineNo")
    public void examineNo(HttpServletRequest request,
                          HttpServletResponse response,
                          Integer id) {
        Goods goods = goodsService.getById(id);
        if (goods == null) {
            WebUtil.print(response, new Result(false).msg("抱歉，数据错误！"));
            return;
        }
        if (StringUtils.equals("no", goods.getIsPass())) {
            WebUtil.print(response, new Result(false).msg("该图片已是不通过状态，请勿重复操作！"));
            return;
        }
        try {
            goods.setIsPass("no");
            goodsService.update(goods);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    /**
     * 删除单个商品图片
     */
    @RequestMapping(value = "/delete")
    public void delete(HttpServletRequest request,
                       HttpServletResponse response,
                       Integer id) {
        try {
            goodsService.deleteGoods(id);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    /**
     * 删除多个商品图片
     */
    @RequestMapping(value = "/deletes")
    public void deletes(HttpServletRequest request,
                        HttpServletResponse response,
                        String ids) {
        try {
            int[] arrayId = JsonUtil.json2Obj(ids, int[].class);
            goodsService.deleteGoods(arrayId);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    /**
     * 跳转至添加商品图页面
     */
    @RequestMapping(value = "/saveUI")
    public String saveUI(HttpServletRequest request,
                         HttpServletResponse response,
                         ModelMap model) {
        return "添加商品图";
    }

    /**
     * 添加商品
     */
    @RequestMapping(value = "/save")
    public void save(HttpServletRequest request,
                     HttpServletResponse response,
                     String goodsName, String goodsKindTagId,
                     String spaceTagIds, String styleTagIds,
                     String price, String size, String texture,
                     String link, String info, String images,
                     String cover, String isTurnMaterialIds) {
        Integer userId = null == SessionUtils.getCurrentUser() ? 0 : SessionUtils.getCurrentUser().getId();
        if (userId == 0) {
            WebUtil.print(response, new Result(false).msg("暂未登录！"));
            return;
        }
        if (StringUtils.isEmpty(goodsName)) {
            WebUtil.print(response, new Result(false).msg("商品名称不可为空！"));
            return;
        }
        if (StringUtils.isEmpty(spaceTagIds)) {
            WebUtil.print(response, new Result(false).msg("请至少选择一个空间类型！"));
            return;
        }
        if (StringUtils.isEmpty(styleTagIds)) {
            WebUtil.print(response, new Result(false).msg("请至少选择一个风格类型！"));
            return;
        }
        if (null == price) {
            WebUtil.print(response, new Result(false).msg("价格不可为空！"));
            return;
        }
        if (StringUtils.isEmpty(size)) {
            WebUtil.print(response, new Result(false).msg("尺寸不可为空！"));
            return;
        }
        if (null == cover) {
            WebUtil.print(response, new Result(false).msg("必须选择一个封面图！"));
            return;
        }
        try {
            goodsService.insert(goodsName, goodsKindTagId, spaceTagIds, styleTagIds, price, size, texture, link, info, images, cover, isTurnMaterialIds, userId);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    @RequestMapping(value = "/updataUI")
    public String updataUI(HttpServletRequest request,
                           HttpServletResponse response,
                           Integer id,
                           ModelMap model) {
        Goods goods = goodsService.getById(id);
        if (goods != null) {

            //种类初始化
            if (StringUtils.isNotEmpty(goods.getKindTagIds())) {
                List<Integer> kingTag = ComFun.tagsToList(goods.getKindTagIds());
                if (kingTag != null && kingTag.size() > 0) {
                    goods.setKindTagId(kingTag.get(0));
                }
            }

            //风格分类初始化
            if (StringUtils.isNotEmpty(goods.getStyleTagIds())) {
                List<Integer> tagIds = ComFun.tagsToList(goods.getStyleTagIds());
                List<Map<String, Object>> styleMap = new ArrayList<Map<String, Object>>();
                //循环给tagNames集合添加标签名称
                for (Integer tagId : tagIds) {
                    StyleTag styleTag = styleTagService.getById(tagId);
                    Map<String, Object> m = new HashMap<String, Object>();
                    m.put("id", tagId);
                    if (styleTag != null) {
                        m.put("name", styleTag.getName());
                    } else {
                        m.put("name", "数据问题");
                    }
                    m.put("type", "styleLx");
                    styleMap.add(m);
                }
                String jsonStyle = JsonUtil.obj2Json(styleMap);
                model.put("jsonStyle", jsonStyle);
            }

            //空间分类初始化
            if (StringUtils.isNotEmpty(goods.getSpaceTagIds())) {
                List<Integer> tagIds = ComFun.tagsToList(goods.getSpaceTagIds());
                List<Map<String, Object>> spaceMap = new ArrayList<Map<String, Object>>();
                //循环给tagNames集合添加标签名称
                for (Integer tagId : tagIds) {
                    SpaceTag spaceTag = spaceTagService.getById(tagId);
                    Map<String, Object> m = new HashMap<String, Object>();
                    m.put("id", tagId);
                    if (spaceTag != null) {
                        m.put("name", spaceTag.getName());
                    } else {
                        m.put("name", "数据问题");
                    }
                    m.put("type", "spaceLx");
                    spaceMap.add(m);
                }
                String jsonSpace = JsonUtil.obj2Json(spaceMap);
                model.put("jsonSpace", jsonSpace);
            }
            List<GoodsImage> images = goodsImageService.listByGoodsId(id);
            List<Map<String, Object>> imgesMap = new ArrayList<Map<String, Object>>();
            for (GoodsImage gi : images) {
                Map<String, Object> im = new HashMap<String, Object>();
                im.put("id", gi.getId());
                im.put("image", gi.getImage());
                im.put("isHead", gi.getIsHead());
                im.put("isTurnMaterial", gi.getIsTurnMaterial());
                imgesMap.add(im);
            }
            String jsonImage = JsonUtil.obj2Json(imgesMap);
            model.put("jsonImage", jsonImage);
        }
        model.put("goods", goods);
        return "编辑商品图";
    }

    @RequestMapping(value = "/updata")
    public void updata(HttpServletRequest request,
                       HttpServletResponse response, Integer goodsId,
                       String goodsName, String goodsKindTagId,
                       String spaceTagIds, String styleTagIds,
                       String price, String size, String texture,
                       String link, String info, String images,
                       String cover, String isTurnMaterialIds) {
        Integer userId = null == SessionUtils.getCurrentUser() ? 0 : SessionUtils.getCurrentUser().getId();
        if (userId == 0) {
            WebUtil.print(response, new Result(false).msg("暂未登录！"));
            return;
        }
        if (StringUtils.isEmpty(goodsName)) {
            WebUtil.print(response, new Result(false).msg("商品名称不可为空！"));
            return;
        }
        if (StringUtils.isEmpty(spaceTagIds)) {
            WebUtil.print(response, new Result(false).msg("请至少选择一个空间类型！"));
            return;
        }
        if (StringUtils.isEmpty(styleTagIds)) {
            WebUtil.print(response, new Result(false).msg("请至少选择一个风格类型！"));
            return;
        }
        if (null == price) {
            WebUtil.print(response, new Result(false).msg("价格不可为空！"));
            return;
        }
        if (StringUtils.isEmpty(size)) {
            WebUtil.print(response, new Result(false).msg("尺寸不可为空！"));
            return;
        }
        if (null == cover) {
            WebUtil.print(response, new Result(false).msg("必须选择一个封面图！"));
            return;
        }
        try {
            goodsService.update(goodsId, goodsName, goodsKindTagId, spaceTagIds, styleTagIds, price, size, texture, link, info, images, cover, isTurnMaterialIds);
            WebUtil.print(response, new Result(true).msg("操作成功！"));
        } catch (Exception e) {
            WebUtil.print(response, new Result(false).msg("操作失败！"));
        }
    }

    /**
     * 跳转至批量导入页面
     */
    @RequestMapping(value = "/batchImportUI")
    public String batchImportUI() {
        return "批量导入";
    }

    /**
     * 检查excle
     */
    @RequestMapping(value = "/checkZip", method = RequestMethod.POST)
    public String checkZip(MultipartHttpServletRequest request, HttpServletResponse response, ModelMap model) {
        MultipartFile file = request.getFile("upload");

        Map<String, Object> map = new HashMap<String, Object>();

        File f = UploadUtils.zhZipFile(file, request);
        if (f == null) {
            map.put("message", "参数错误，请传入正确的流文件！");//提示消息
            map.put("code", "0");//code:1为检查无错,0为检查不通过
            map.put("color", "red");//消息显示颜色
            model.put("info", map);
            return "批量导入";
        }
        ZipFile zipFile = null;
        try {
            zipFile = new ZipFile(f);
        } catch (IOException e) {
            if (zipFile == null) {
                map.put("message", "参数错误，请传入正确的流文件！");//提示消息
                map.put("code", "0");//code:1为检查无错,0为检查不通过
                map.put("color", "red");//消息显示颜色
                model.put("info", map);
                return "批量导入";
            }
        }
        if (zipFile == null) {
            map.put("message", "参数错误，请传入正确的流文件！");//提示消息
            map.put("code", "0");//code:1为检查无错,0为检查不通过
            map.put("color", "red");//消息显示颜色
            model.put("info", map);
            return "批量导入";
        }
        List<Map<String, Object>> excleMaps = new ArrayList<Map<String, Object>>();
        Map<String, Object> scMap = new HashMap<>();
        Map<String, Object> goMap = new HashMap<>();
        String path = f.getParentFile().getPath();
        ZipUtil.unZip(f.getPath(), path + "/");
        scMap.put("path", path + "/" + "scene");
        excleMaps.add(scMap);
        goMap.put("path", path + "/" + "goods");
        excleMaps.add(goMap);

        //检测excle是否有效
        if (excleMaps == null) {
            map.put("message", "检测错误，请确认zip包中文件没有受损！");//提示消息
            map.put("code", "0");//code:1为检查无错,0为检查不通过
            map.put("color", "red");//消息显示颜色
            model.put("info", map);
            return "批量导入";
        }

        //检测excle是否有效 只有两个路径
        if (excleMaps.size() != 2) {
            map.put("message", "检测错误，请确认zip包中数据的正确性！");//提示消息
            map.put("code", "0");//code:1为检查无错,0为检查不通过
            map.put("color", "red");//消息显示颜色
            model.put("info", map);
            return "批量导入";
        }
        //检测excle中数据是否有效
        if (excleMaps.get(0).size() <= 0) {
            map.put("message", "检测错误，请确认zip包中数据的正确性！");//提示消息
            map.put("code", "0");//code:1为检查无错,0为检查不通过
            map.put("color", "red");//消息显示颜色
            model.put("info", map);
            return "批量导入";
        }

        //excleMaps中第一行放的是场景图路径
        List scenePathList = FileUtil.getFileList(excleMaps.get(0).get("path").toString());
        if (scenePathList == null || scenePathList.size() <= 0) {
            map.put("message", "检测错误，场景图文件夹下无文件！");//提示消息
            map.put("code", "0");//code:1为检查无错,0为检查不通过
            map.put("color", "red");//消息显示颜色
            model.put("info", map);
            return "批量导入";
        }
        //excleMaps中第二行放的是商品图路径
        List goodsPathList = FileUtil.getFileList(excleMaps.get(1).get("path").toString());
        if (goodsPathList == null || goodsPathList.size() <= 0) {
            map.put("message", "检测错误，商品图文件夹下无文件！");//提示消息
            map.put("code", "0");//code:1为检查无错,0为检查不通过
            map.put("color", "red");//消息显示颜色
            model.put("info", map);
            return "批量导入";
        }

        //将excle文件信息放入session
        SessionUtils.put8Hour("excleMaps", excleMaps);
        //操作文件目录
        SessionUtils.put8Hour("bPath", path + "/");

        map.put("message", "ZIP检测通过，开始检查场景图excle与商品excle有效性...");//提示消息
        map.put("code", "1");//code:1为检查无错,0为检查不通过
        map.put("color", "green");//消息显示颜色
        model.put("info", map);
        return "批量导入";
    }

    /**
     * 批量导入
     */
    @RequestMapping(value = "/batchImport", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> batchImport(HttpServletRequest request, HttpServletResponse response, int status, int sceneIndex, int goodsIndex) {
        //获取当前登录用户
        Integer userId = null == SessionUtils.getCurrentUser() ? 0 : SessionUtils.getCurrentUser().getId();

        //Excle工具类
        ExcelUtil eu = new ExcelUtil();

        //传递消息的map
        Map<String, Object> messageMap = new HashMap<String, Object>();

        if (userId == 0) {
            messageMap.put("message", "请检测登录是否已失效！");//提示消息
            messageMap.put("code", "0");//code:1为检查无错,0为检查不通过
            messageMap.put("color", "red");//消息显示颜色
            return messageMap;
        }
        //填充 场景列表
        List<Map<String, Object>> sceneList = new ArrayList<Map<String, Object>>();
        //填充 商品列表
        List<Map<String, Object>> goodsList = new ArrayList<Map<String, Object>>();
        if (status == 0) {
            //上传完毕或失败清空session
            SessionUtils.clear("file");
            SessionUtils.clear("messageMap");
            //清空缓存集合
            SessionUtils.clear("sceneList");
            SessionUtils.clear("goodsList");
            SessionUtils.clear("status");
            if (SessionUtils.get("bPath") != null) {
                String path = SessionUtils.get("bPath").toString();
                FileUtil.deleteFiles(path);
            }
            SessionUtils.clear("bPath");
            //结束时初始化消息提醒
            messageMap.put("message", "运行结束");
            messageMap.put("code", "2");//为空就是不继续检查
            messageMap.put("color", "green");
            return messageMap;
        } else if (status == 1) {
            if (SessionUtils.get("status") != null) { //状态 Y:全部检测通过 其他情况，均属为检测通过
                if (StringUtils.equals(SessionUtils.get("status").toString(), "Y")) {
                    //检测全部通过后，开始导入
                    Map<String, Object> map = goodsService.batchImport(userId, sceneIndex, goodsIndex);
                    //任何一条失败就清空session
                    if (map == null) {
                        SessionUtils.clear("sceneList");
                        SessionUtils.clear("goodsList");
                        SessionUtils.clear("status");
                    }
                    return map;
                } else {
                    messageMap.put("message", "运行结束");
                    messageMap.put("code", "0");
                    messageMap.put("color", "green");
                    return messageMap;
                }
            }

            //获取出所有空间标签
            List<SpaceTag> sps = spaceTagService.findAll();
            //封装空间标签
            Map<String, Object> spsMap = new HashMap<String, Object>();
            for (SpaceTag spt : sps) {
                spsMap.put(spt.getName(), spt.getId());
            }
            //获取出所有风格标签
            List<StyleTag> sts = styleTagService.findAll();
            //封装风格标签
            Map<String, Object> stsMap = new HashMap<String, Object>();
            for (StyleTag stt : sts) {
                stsMap.put(stt.getName(), stt.getId());
            }
            //获取出所有种类
            List<KindTag> kts = kindTagService.findAll();
            //封装种类
            Map<String, Object> ktsMap = new HashMap<String, Object>();
            for (KindTag kt : kts) {
                ktsMap.put(kt.getName(), kt.getId());
            }

            //从session中取出excle信息
            List<Map<String, Object>> excleMaps = (List<Map<String, Object>>) SessionUtils.get("excleMaps");
            //场景图
            List sceneExclePathList = FileUtil.getFileList(excleMaps.get(0).get("path").toString(), "sceneXls");
            if (sceneExclePathList == null || sceneExclePathList.size() < 1) {
                messageMap.put("message", "请确认场景图excle存在，并且格式正确！");
                messageMap.put("code", "0");
                messageMap.put("color", "red");
                return messageMap;
            }
            //检测场景图excle与数据是否合法
            File sceneExcle = new File(sceneExclePathList.get(0).toString());
            List<Map<String, Object>> sceneExcleMap = eu.readExcelToObj(sceneExcle, 0, 0, 0);
            if (sceneExcleMap == null || sceneExcleMap.size() < 1) {
                messageMap.put("message", "请确认sceneXls.xlsx的格式正确，并且数据正确");
                messageMap.put("code", "0");
                messageMap.put("color", "red");
                return messageMap;
            }
            //去掉头部信息
            sceneExcleMap.remove(0);
            for (Map<String, Object> sceneM : sceneExcleMap) {
                //加入场景的map集合
                Map<String, Object> sm = new HashMap<String, Object>();
                List scene = FileUtil.getFileList(excleMaps.get(0).get("path").toString(), sceneM.get("name").toString());
                if (scene == null || scene.size() < 1) {
                    messageMap.put("message", "请确认(" + sceneM.get("name").toString() + ")场景图文件存在！");
                    messageMap.put("code", "0");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                //设置场景名称
                sm.put("name", sceneM.get("name").toString());
                //设置图片绝对路径
                sm.put("imagePath", scene.get(0).toString());

                if (sceneM.get("space") != null && sceneM.get("style") != null) {
                    String space[] = sceneM.get("space").toString().split(",");
                    String spaceM = "";
                    for (String spName : space) {
                        String spName1 = spName.replace(" ", "");
                        if (spsMap.get(spName1) == null) {
                            messageMap.put("message", "(" + spName + ")空间标签不存在，请先添加此标签！");
                            messageMap.put("code", "0");
                            messageMap.put("color", "red");
                            return messageMap;
                        }
                        spaceM += spsMap.get(spName1) + ",";
                    }
                    //设置空间标签
                    sm.put("space", spaceM);

                    String style[] = sceneM.get("style").toString().split(",");
                    String styleM = "";
                    for (String stName : style) {
                        String stName1 = stName.replace(" ", "");
                        if (stsMap.get(stName1) == null) {
                            messageMap.put("message", "(" + stName + ")风格标签不存在，请先添加此标签！");
                            messageMap.put("code", "0");
                            messageMap.put("color", "red");
                            return messageMap;
                        }
                        styleM += stsMap.get(stName1) + ",";
                    }

                    //设置空间标签
                    sm.put("style", styleM);
                } else {
                    messageMap.put("message", "请检查(" + sceneM.get("name").toString() + ")的space和style是否为空！");
                    messageMap.put("code", "0");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                if (sceneM.get("info") == null) sm.put("info", "");
                else sm.put("info", sceneM.get("info").toString());


                //设置场景会否显示
                sm.put("isShow", sceneM.get("isShow").toString());
                sceneList.add(sm);
            }

            //商品图
            List goodsExclePathList = FileUtil.getFileList(excleMaps.get(1).get("path").toString(), "goodsXls");
            if (goodsExclePathList == null || goodsExclePathList.size() < 1) {
                messageMap.put("message", "请确认商品图excle存在，并且格式正确！");
                messageMap.put("code", "0");
                messageMap.put("color", "red");
                return messageMap;
            }
            //检测商品excle与数据是否合法
            File goodsExcle = new File(goodsExclePathList.get(0).toString());
            List<Map<String, Object>> goodsExcleMap = eu.readExcelToObj(goodsExcle, 0, 0, 0);
            if (goodsExcleMap == null || goodsExcleMap.size() < 1) {
                messageMap.put("message", "请确认goodsXls.xlsx的格式正确，并且数据正确(可以尝试选中excle全部数据，然后清除格式)");
                messageMap.put("code", "0");
                messageMap.put("color", "red");
                return messageMap;
            }
            //去掉头部信息
            goodsExcleMap.remove(0);
            for (Map<String, Object> goodsM : goodsExcleMap) {
                //加入商品的map集合
                Map<String, Object> gm = new HashMap<String, Object>();
                if (goodsM.get("scene") != null) {
                    //设置商品所属场景
                    gm.put("scene", goodsM.get("scene").toString());
                } else {
                    //设置场景为空
                    gm.put("scene", "");
                }
                if (goodsM.get("price") != null) {
                    //设置商品价格
                    gm.put("price", goodsM.get("price").toString());
                } else {
                    //设置价格为空
                    gm.put("price", "");
                }
                if (goodsM.get("size") != null) {
                    //设置商品尺寸
                    gm.put("size", goodsM.get("size").toString());
                } else {
                    //设置尺寸为空
                    gm.put("size", "");
                }
                if (goodsM.get("texture") != null) {
                    //设置商品材质
                    gm.put("texture", goodsM.get("texture").toString());
                } else {
                    //设置尺寸材质
                    gm.put("texture", "");
                }
                if (goodsM.get("link") != null) {
                    //设置商品购买链接
                    gm.put("link", goodsM.get("link").toString());
                } else {
                    //设置购买链接为空
                    gm.put("link", "");
                }
                if (goodsM.get("info") != null) {
                    //设置商品描述
                    gm.put("info", goodsM.get("info").toString());
                } else {
                    //设置描述为空
                    gm.put("info", "");
                }
                if (goodsM.get("name") != null) {
                    //设置商品名称
                    gm.put("name", goodsM.get("name").toString());
                    List goodsPathList = FileUtil.getFileList(excleMaps.get(1).get("path").toString(), goodsM.get("name").toString());
                    if (goodsPathList == null || goodsPathList.size() < 1) {
                        messageMap.put("message", "请确认商品文件夹中存在(" + goodsM.get("name").toString() + ")！");
                        messageMap.put("code", "0");
                        messageMap.put("color", "red");
                        return messageMap;
                    }
                    //获取所有.jpg文件
                    List<File> goodsFilePathList = new ArrayList<File>();
                    List<String> suffixsj = new ArrayList<String>();
                    suffixsj.add("jpg");
                    //不转为素材图的商品图
                    goodsFilePathList = FileUtil.getAllFiles(goodsFilePathList, suffixsj, goodsPathList.get(0).toString());
                    gm.put("goodImages", goodsFilePathList);
                    //获取所有.png文件
                    List<File> materialFilePathList = new ArrayList<File>();
                    List<String> suffixsp = new ArrayList<String>();
                    suffixsp.add("png");
                    materialFilePathList = FileUtil.getAllFiles(materialFilePathList, suffixsp, goodsPathList.get(0).toString());
                    //设置转为素材的图片
                    gm.put("materialImages", materialFilePathList);
                    //获取商品封面图
                    List goodsCoverList = FileUtil.getFileListByFileName(goodsPathList.get(0).toString(), "cover");
                    if (goodsCoverList == null || goodsCoverList.size() < 1) {
                        messageMap.put("message", "请确认(" + goodsM.get("name").toString() + ")商品中是否包含cover设置封面图！");
                        messageMap.put("code", "0");
                        messageMap.put("color", "red");
                        return messageMap;
                    }
                } else {
                    messageMap.put("message", "请确认商品图excle数据正确！");
                    messageMap.put("code", "0");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                if (goodsM.get("space") != null && goodsM.get("style") != null) {
                    String spaceM = "";
                    String space[] = goodsM.get("space").toString().split(",");
                    for (String spName : space) {
                        String spName1 = spName.replace(" ", "");
                        if (spsMap.get(spName1) == null) {
                            messageMap.put("message", "(" + spName + ")空间标签不存在，请先添加此标签！");
                            messageMap.put("code", "0");
                            messageMap.put("color", "red");
                            return messageMap;
                        }
                        spaceM += spsMap.get(spName1) + ",";
                        gm.put("space", spaceM);
                    }
                    String styleM = "";
                    String style[] = goodsM.get("style").toString().split(",");
                    for (String stName : style) {
                        String stName1 = stName.replace(" ", "");
                        if (stsMap.get(stName1) == null) {
                            messageMap.put("message", "(" + stName + ")风格标签不存在，请先添加此标签！");
                            messageMap.put("code", "0");
                            messageMap.put("color", "red");
                            return messageMap;
                        }
                        styleM += stsMap.get(stName1) + ",";
                        gm.put("style", styleM);
                    }
                } else {
                    messageMap.put("message", "请检查(" + goodsM.get("name").toString() + ")的space和style是否为空！");
                    messageMap.put("code", "0");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                if (goodsM.get("kind") != null) {
                    String kName = (String) goodsM.get("kind");
                    String kindM = "";
                    String kName1 = kName.replace(" ", "");
                    if (ktsMap.get(kName1) == null) {
                        messageMap.put("message", "(" + kName + ")分类不存在，请先添加此分类！");
                        messageMap.put("code", "0");
                        messageMap.put("color", "red");
                        return messageMap;
                    }
                    kindM += ktsMap.get(kName1);
                    gm.put("kind", kindM);
                } else {
                    messageMap.put("message", "请检查(" + goodsM.get("name").toString() + ")商品的kind是否为空");
                    messageMap.put("code", "0");
                    messageMap.put("color", "red");
                    return messageMap;
                }
                goodsList.add(gm);
            }

            //全部检测通过就将场景图与商品的集合存入session
            SessionUtils.put("status", "Y");
            if (sceneList == null || sceneList.size() < 1) {
                messageMap.put("message", "请检查场景图excle中是否存在数据错误");
                messageMap.put("code", "1");
                messageMap.put("color", "green");
                return messageMap;
            }
            SessionUtils.put("sceneList", sceneList);
            if (goodsList == null || goodsList.size() < 1) {
                messageMap.put("message", "请检查商品图excle中是否存在数据错误");
                messageMap.put("code", "1");
                messageMap.put("color", "green");
                return messageMap;
            }
            SessionUtils.put("goodsList", goodsList);
            messageMap.put("message", "场景图与商品图excle检测成功，开始上传场景与商品");
            messageMap.put("code", "1");
            messageMap.put("color", "green");
            return messageMap;
        }
        return null;
    }

}

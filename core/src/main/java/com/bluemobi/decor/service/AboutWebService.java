package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.AboutWeb;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by tuyh on 2015/7/23 14:04.
 */
public interface AboutWebService extends ICommonService<AboutWeb> {

    // 根据标题查询关于网站的信息
    public Page<AboutWeb> pageWithTitle(int pageNum, int pageSize, String title);

    // 获取关于我们信息
    public AboutWeb iGetAboutUS();

    public List<AboutWeb> all();
}
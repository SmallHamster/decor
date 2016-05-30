package com.bluemobi.decor.service;

import com.bluemobi.decor.entity.Background;
import com.bluemobi.decor.service.common.ICommonService;
import org.springframework.data.domain.Page;

public interface BackgroundService extends ICommonService<Background> {

    Page<Background> page(int pageNum, int pageSize);
}
package com.bluemobi.decor.dao;

import com.bluemobi.decor.entity.Background;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * Created by gaoll on 2015/3/3.
 */
public interface BackgroundDao extends JpaRepository<Background, Integer>,JpaSpecificationExecutor<Background> {


}

package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.UserThirdDao;
import com.bluemobi.decor.entity.User;
import com.bluemobi.decor.entity.UserThird;
import com.bluemobi.decor.service.UserThirdService;
import com.bluemobi.decor.utils.ClassUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by tuyh on 2015/7/7.
 */
@Service
@Transactional(readOnly = true)
public class UserThirdServiceImpl implements UserThirdService {

    @Autowired
    private UserThirdDao userThirdDao;

    @Override
    public List<UserThird> findAll() {
        return userThirdDao.findAll();
    }

    @Override
    public Page<UserThird> find(int pageNum, int pageSize) {

        return userThirdDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<UserThird> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public UserThird getById(int id) {
        return userThirdDao.findOne(id);
    }

    @Override
    @Transactional
    public UserThird deleteById(int id) {
        UserThird userThird = getById(id);
        userThirdDao.delete(userThird);
        return userThird;
    }

    @Override
    @Transactional
    public UserThird create(UserThird userThird) {
        UserThird ut = userThirdDao.findByOpenidAndType(userThird.getOpen_id(),userThird.getType());
        if(ut == null){
            userThirdDao.save(userThird);
        }
        return userThird;
    }

    @Override
    @Transactional
    public UserThird update(UserThird o) {
        UserThird dest = getById(o.getId());
        ClassUtil.copyProperties(dest, o);
        return userThirdDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    @Transactional
    public UserThird iFindByOpenId(String open_id, String type) {
        List<UserThird> list = userThirdDao.iFindByOpenId(open_id, type);
        if(list == null || list.size() == 0){
            return null;
        }else {
            for (int i = 1; i < list.size(); i++) {
                UserThird ut = list.get(i);
                userThirdDao.delete(ut);
            }
            return list.get(0);
        }
    }

    @Override
    public List<UserThird> iFindUserThirdWithUser(User user) {
        return userThirdDao.iFindUserThirdWithUser(user);
    }

    @Override
    public List<UserThird> findByUserIdAndType(Integer userId, String type) {
        return userThirdDao.findByUserIdAndType(userId,type);
    }
}
package com.bluemobi.decor.service.impl;

import com.bluemobi.decor.core.Constant;
import com.bluemobi.decor.dao.*;
import com.bluemobi.decor.entity.*;
import com.bluemobi.decor.service.TRoleService;
import com.bluemobi.decor.service.TUserRoleService;
import com.bluemobi.decor.service.UserService;
import com.bluemobi.decor.utils.ClassUtil;
import com.bluemobi.decor.utils.JsonUtil;
import com.bluemobi.decor.utils.Md5Util;
import com.bluemobi.decor.utils.SessionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by gaoll on 2015/7/3.
 */
@Service
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private ProvinceDao provinceDao;
    @Autowired
    private CityDao cityDao;
    @Autowired
    private SeriesDao seriesDao;

    @Autowired
    private TUserRoleService tUserRoleService;

    @Autowired
    private UserThirdDao userThirdDao;

    @Autowired
    private AttentionDao attentionDao;
    @Autowired
    private TRoleService TRoleService;

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public Page<User> find(int pageNum, int pageSize) {

        return userDao.findAll(new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

    }

    @Override
    public Page<User> find(int pageNum) {
        return find(pageNum, Constant.PAGE_DEF_SZIE);
    }

    @Override
    public User getById(int id) {
        return userDao.findOne(id);
    }

    @Override
    @Transactional
    public User deleteById(int id) {
        User user = getById(id);
        userDao.delete(user);
        return user;
    }

    @Override
    @Transactional
    public User create(User user) {
        if (StringUtils.isEmpty(user.getIsRecommend())) {
            user.setIsRecommend(Constant.USER_INFO_IsRECOMMEND_NO);
        }
        if (StringUtils.isEmpty(user.getStatus())) {
            user.setStatus(Constant.USER_ENABLE);
        }
        if (StringUtils.isEmpty(user.getUserType())) {
            user.setUserType(Constant.USER_USERTYPE_COMMON);
        }
        if (StringUtils.isEmpty(user.getNickname())) {
            user.setNickname(user.getAccount());
        }
        if (user.getSeeNum() == null) {
            user.setSeeNum(0);
        }
        if (user.getOpus() == null) {
            user.setOpus(0);
        }
        // 设置城市默认值
        if (user.getCity() == null) {
            City city = new City();
            city.setId(1);
            user.setCity(city);
        }
        if (user.getCreateTime() == null) {
            user.setCreateTime(new Date());
        }
        userDao.save(user);
        return user;
    }

    @Override
    @Transactional
    public User update(User o) {
        User dest = getById(o.getId());
        String mobile = dest.getMobile();
        String account = dest.getAccount();
        ClassUtil.copyProperties(dest, o);
        dest.setAccount(account);
        dest.setMobile(mobile);
        return userDao.save(dest);
    }

    @Override
    @Transactional
    public void deleteAll(int[] ids) {
        for (int id : ids) {
            deleteById(id);
        }
    }

    @Override
    public Boolean backendLogin(String username, String password) {
        List<User> userList = userDao.iFindByMobileAndPassword(username, password);
        if (userList == null || userList.size() == 0) {
            return false;
        } else {
            SessionUtils.put("user", userList.get(0));
            return true;
        }
    }

    @Override
    public User pcLogin(String username, String password) {
        List<User> userList = userDao.getByMobileAndPassword(username, password);
        if (userList == null || userList.size() == 0) {
            return null;
        } else {
            String nickname = userList.get(0).getNickname();
            String shortNickname = nickname;
            if (nickname != null && nickname.length() > 4) {
                shortNickname = nickname.substring(0, 4) + "...";
            }
            userList.get(0).setShortNickname(shortNickname);
            SessionUtils.put(Constant.SESSION_PC_USER, userList.get(0));
            return userList.get(0);
        }
    }

    @Override
    public User pcLoginPlus(String username, String password) {
        List<User> userList = userDao.getByNicknameAndPassword(username, password);
        if (userList == null || userList.size() == 0) {
            return null;
        } else {
            String nickname = userList.get(0).getNickname();
            String shortNickname = nickname;
            if (nickname != null && nickname.length() > 4) {
                shortNickname = nickname.substring(0, 4) + "...";
            }
            userList.get(0).setShortNickname(shortNickname);
            SessionUtils.put(Constant.SESSION_PC_USER, userList.get(0));
            return userList.get(0);
        }
    }


    @Override
    public User iFindByMobile(String mobile) {
        List<User> userList = userDao.iFindByMobile(mobile);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        }
        return null;
    }

    @Override
    public User findByMobile(String mobile) {
        List<User> userList = userDao.iFindByMobile(mobile);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        }
        return null;
    }

    @Override
    public User iFindByNickname(String nickname) {
        List<User> userList = userDao.iFindByNickname(nickname);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        }
        return null;
    }

    @Override
    public User iFindByAccount(String account) {
        List<User> userList = userDao.findByAccount(account);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        }
        return null;
    }

    @Override
    public User iFindByMobileAndPassword(String mobile, String password) {
        List<User> userList = userDao.iFindByMobileAndPassword(mobile, password);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        }
        return null;
    }

    @Override
    @Transactional
    public User iRegister(User user) {
        return create(user);
    }

    @Override
    @Transactional
    public String pcRegister(User user) {
        if (StringUtils.isEmpty(user.getMobile())) {
            return "mobileIsEmpty";
        }

        User u = findByMobile(user.getMobile());
        if (u != null) {
            return "mobileIsExist";
        }

        create(user);
        return "success";
    }

    @Override
    @Transactional
    public String pcResetPassword(String mobile, String password) {
        User user = findByMobile(mobile);
        if (user != null) {
            user.setPassword(password);
        }
        return "success";
    }

    @Override
    @Transactional
    public void bindingOpenId(User user, String open_id, String type) {
        UserThird ut = new UserThird();
        ut.setOpen_id(open_id);
        ut.setUser(user);
        ut.setType(type);
        userThirdDao.save(ut);
    }

    @Override
    public UserThird iCheckBinding(User user, String open_id, String type) {
        return userThirdDao.iCheckBinding(user, open_id, type);
    }

    @Override
    public UserThird findByOpenidAndType(String open_id, String type) {
        return userThirdDao.findByOpenidAndType(open_id, type);
    }

    @Override
    public Page<User> iPageUser(final Integer cityId, final String name, final String sort, Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.ASC, "id");

        // opusMost   案例数最多
        // fansMost   粉丝数最多
        if (null != sort) {
            if ("opusMost".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "opus");
            } else {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "fans");
            }
        }

        Page<User> page = userDao.findAll(new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                Predicate predicate = cb.equal(root.get("roleType").as(String.class), Constant.ROLE_MEMBER);
                predicateList.add(predicate);

                Predicate predicates = cb.equal(root.get("status").as(String.class), "enable");
                predicateList.add(predicates);

                if (StringUtils.isNotEmpty(name)) {
                    predicate = cb.like(root.get("nickname").as(String.class), "%" + name + "%");
                    predicateList.add(predicate);
                }
                if (null != cityId) {
                    predicate = cb.equal(root.get("city").get("id").as(Integer.class), cityId);
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }

                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, pageRequest);

        return page;
    }

    @Override
    public Page<User> bAdmin(Integer pageNum, Integer pageSize, final String nickname, final String account) {
        Page<User> page = userDao.findAll(new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                {
                    Predicate predicate = cb.equal(root.get("roleType").as(String.class), "admin");
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(nickname)) {
                    Predicate predicate = cb.like(root.get("nickname").as(String.class), "%" + nickname + "%");
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(account)) {
                    Predicate predicate = cb.like(root.get("account").as(String.class), "%" + account + "%");
                    predicateList.add(predicate);
                }


                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }

                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

        return page;
    }

    @Override
    public Page<User> QAdmin(Integer pageNum, Integer pageSize, final String nickname, final String account, final Integer id) {
        Page<User> page = userDao.findAll(new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                Predicate predicates = cb.equal(root.get("roleType").as(String.class), Constant.ROLE_MEMBER);
                predicateList.add(predicates);

                if (null != id) {
                    Predicate predicate = cb.equal(root.get("id").as(Integer.class), id);
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(nickname)) {
                    Predicate predicate = cb.like(root.get("nickname").as(String.class), "%" + nickname + "%");
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(account)) {
                    Predicate predicate = cb.like(root.get("account").as(String.class), "%" + account + "%");
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }

                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

        return page;
    }

    @Override
    public Page<User> BAdmin(Integer pageNum, Integer pageSize, final String nickname, final String account, final Integer id) {
        Sort sort = new Sort(Sort.Direction.DESC, "recommendTime").and(new Sort(Sort.Direction.DESC, "id"));

        Page<User> page = userDao.findAll(new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                Predicate predicates = cb.equal(root.get("roleType").as(String.class), Constant.ROLE_MEMBER);
                predicateList.add(predicates);

                if (null != id) {
                    Predicate predicate = cb.equal(root.get("id").as(Integer.class), id);
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(nickname)) {
                    Predicate predicate = cb.like(root.get("nickname").as(String.class), "%" + nickname + "%");
                    predicateList.add(predicate);
                }
                if (StringUtils.isNotEmpty(account)) {
                    Predicate predicate = cb.like(root.get("account").as(String.class), "%" + account + "%");
                    predicateList.add(predicate);
                }

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }

                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(pageNum - 1, pageSize, sort));

        return page;
    }

    @Override
    @Transactional
    public void changeStatus(Integer id, String status) {
        User user = userDao.findOne(id);
        user.setStatus(status);
        update(user);
    }

    @Override
    @Transactional
    public void batchChangeStatus(String ids, String status) {
        int[] arrayId = JsonUtil.json2Obj(ids, int[].class);
        User user = null;
        for (int i = 0; i < arrayId.length; i++) {
            user = userDao.findOne(arrayId[i]);
            user.setStatus(status);
            update(user);
        }
    }

    @Override
    @Transactional
    public void changeRecommend(Integer id, String isRecommend) {
        User user = userDao.findOne(id);
        user.setIsRecommend(isRecommend);
        if (isRecommend.equals("yes")) {
            user.setRecommendTime(new Date());
        } else {
            user.setRecommendTime(null);
        }
        update(user);
    }

    @Override
    @Transactional
    public User saveAdmin(User user, Integer roleId) {
        TRole tRole1 = null;
        if (user.getId() == null) {
            if (null != roleId && roleId > 0) {
                tRole1 = TRoleService.getById(roleId);
                user.setNickname(tRole1.getName());
            }

            user.setRoleType(Constant.ROLE_ADMIN);
            user.setMobile(user.getAccount());
            user.setStatus(Constant.USER_ENABLE);
            user.setIsShow(Constant.USER_INFO_IsSHOW_NO);
            user.setFans(Constant.FANS_Num);
            user.setOpus(Constant.USER_OPUS);
            user.setSeeNum(Constant.USER_SEENUM);
            user.setUserType(Constant.USER_USERTYPE_COMMON);
            user.setPassword(Md5Util.md5(user.getPassword()));
            user = create(user);
        } else {
            user.setAccount(null); // 表示账号不能修改
            user.setPassword(Md5Util.md5(user.getPassword()));
            user = update(user);
        }

        // 保存管理员权限
        TUserRole tUserRole = tUserRoleService.findByUserId(user.getId());
        // 保存新权限
        if (roleId != null) {
            if (tUserRole == null) {
                tUserRole = new TUserRole();
                tUserRole.setUser(user);
            }
            if (null != roleId && roleId > 0) {
                TRole tRole = new TRole();
                tRole.setId(roleId);
                tUserRole.setRole(tRole);
            }
            if (tUserRole.getId() == null) {
                tUserRoleService.create(tUserRole);
            } else {
                tUserRoleService.update(tUserRole);
            }
        }
        // 删除权限
        else {
            if (tUserRole != null) {
                tUserRoleService.deleteById(tUserRole.getId());
            }
        }
        return user;
    }

    @Override
    public Boolean isAccountExist(String account) {
        List<User> userList = userDao.findByAccount(account);
        if (userList == null || userList.size() == 0) {
            return false;
        } else {
            return true;
        }
    }

    @Override
    public Page<User> PageToMain(Integer pageNum, Integer pageSize) {
        Page<User> page = userDao.findAll(new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                Predicate predicates = cb.equal(root.get("roleType").as(String.class), Constant.ROLE_MEMBER);
                predicateList.add(predicates);

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }

                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id"));

        return page;
    }

    @Override
    @Transactional
    public String iModifyPassword(Integer userId, String oldPassword, String newPassword) {
        User user = getById(userId);
        if (!oldPassword.equals(user.getPassword())) {
            return "passwordWrong";
        }
        user.setPassword(newPassword);
        update(user);
        return "success";
    }

    @Override
    public List<Province> showProvince() {
        return provinceDao.findAll();
    }

    @Override
    public List<City> showCity(Integer provinceId) {
        Province province = new Province();
        province.setId(provinceId);
        return cityDao.findCityByProvince(province);
    }

    @Override
    public Page<User> pcPage(Integer pageNum, Integer pageSize, final Integer cityId, final String sort, final String name, final Integer provinceId) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "isRecommend", "id");
        if (!sort.equals("")) {
            if ("sort".equals(sort)) {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "isRecommend", "opus");
            } else {
                pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "isRecommend", "fans");
            }
        }
        Page<User> page = userDao.findAll(new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                Predicate predicates = cb.equal(root.get("status").as(String.class), "enable");
                predicateList.add(predicates);

                Predicate predicates1 = cb.equal(root.get("roleType").as(String.class), "member");
                predicateList.add(predicates1);

                if (StringUtils.isNotEmpty(name)) {
                    Predicate predicate = cb.like(root.get("nickname").as(String.class), "%" + name + "%");
                    predicateList.add(predicate);
                }

                if (cityId != null) {
                    Predicate predicate = cb.equal(root.get("city").get("id").as(Integer.class), cityId);
                    predicateList.add(predicate);
                }
                if (provinceId != null) {
                    Predicate predicate = cb.equal(root.get("city").get("province").get("id").as(Integer.class), provinceId);
                    predicateList.add(predicate);
                }
                Predicate predicate = cb.notEqual(root.get("roleType").as(String.class), "admin");
                predicateList.add(predicate);
                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, pageRequest);
        List<User> listUser = page.getContent();
        for (int i = 0; i < listUser.size(); i++) {
            final Integer userId = listUser.get(i).getId();
            Integer cityIdToS = listUser.get(i).getCity().getId();
            Integer provinceIdTo = cityDao.findOne(cityIdToS).getProvince().getId();
            String provinceName = provinceDao.findOne(provinceIdTo).getName();
            Province province = new Province();
            province.setName(provinceName);
            province.setId(provinceId);
            listUser.get(i).setProvince(province);
            Page<Series> seriesPage = seriesDao.findAll(new Specification<Series>() {
                @Override
                public Predicate toPredicate(Root<Series> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                    List<Predicate> predicateList = new ArrayList<Predicate>();
                    Predicate result = null;
                    if (userId != null) {
                        Predicate predicate = cb.equal(root.get("user").get("id").as(Integer.class), userId);
                        predicateList.add(predicate);
                    }
                    if (predicateList.size() > 0) {
                        result = cb.and(predicateList.toArray(new Predicate[]{}));
                    }
                    if (result != null) {
                        query.where(result);
                    }

                    return query.getRestriction();
                }

            }, new PageRequest(pageNum - 1, 4, Sort.Direction.DESC, "createTime"));
            List<Series> seriesList = seriesPage.getContent();
            for (int j = 0; j < seriesList.size(); j++) {
                seriesList.get(j).setUser(null);
            }
            listUser.get(i).setSeriesList(seriesList);
        }

        return page;
    }

    @Override
    public List<User> maxFans() {
        Page<User> page = userDao.findAll(new Specification<User>() {
            @Override
            public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicateList = new ArrayList<Predicate>();
                Predicate result = null;

                Predicate predicate = cb.equal(root.get("status").as(String.class), "enable");
                predicateList.add(predicate);

                Predicate predicates1 = cb.equal(root.get("roleType").as(String.class), "member");
                predicateList.add(predicates1);

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }
                if (result != null) {
                    query.where(result);
                }

                return query.getRestriction();
            }

        }, new PageRequest(0, 4, Sort.Direction.DESC, "fans", "isRecommend"));
        List<User> userList = page.getContent();
        for (int i = 0; i < userList.size(); i++) {
            Integer cityIdToS2 = userList.get(i).getCity().getId();
            Integer provinceId = cityDao.findOne(cityIdToS2).getProvince().getId();
            String provinceName = provinceDao.findOne(provinceId).getName();
            Province province = new Province();
            province.setName(provinceName);
            province.setId(provinceId);
            userList.get(i).setProvince(province);
        }


        return page.getContent();
    }

    @Override
    public boolean IsAttentionByUser(Integer userId, Integer sessionUserId) {
        User user = getById(userId);
        User sessionUser = getById(sessionUserId);
        if (user == null || sessionUser == null) {
            return false;
        } else {
            List<Attention> attentionList = attentionDao.iCheckUser(user, sessionUser);
            if (attentionList == null || attentionList.size() == 0) {
                return false;
            } else {
                return true;
            }
        }
    }

    @Override
    @Transactional
    public void updateIsAttention(Integer userId, Integer sessionUserId, boolean addOrDel) {
        User user = getById(userId);
        User sessionUser = getById(sessionUserId);
        List<Attention> attentionList = attentionDao.iCheckUser(user, sessionUser);
        if (addOrDel) {
            Attention attentionTo = new Attention();
            attentionTo.setFansUser(sessionUser);
            attentionTo.setAttentionUser(user);
            attentionTo.setUserHasUpdate("0");
            attentionDao.save(attentionTo);
        } else {
            for (int i = 0; i < attentionList.size(); i++) {
                attentionDao.delete(attentionList.get(i));
            }
        }
    }

    @Override
    @Transactional
    public void updateFansNum(Integer userId, boolean addOrDel) {
        User user = getById(userId);
        if (addOrDel) {
            user.setFans(user.getFans() + 1);
        } else {
            if (user.getFans() > 0) {
                user.setFans(user.getFans() - 1);
            }
        }
        update(user);
    }

    @Override
    @Transactional
    public void updateUser(User user) {
        update(user);
    }

    @Override
    @Transactional
    public void fansNumAddOne(Integer userId) {
        User user = getById(userId);
        Integer num = user.getFans();
        if (num == null) {
            num = 0;
        }
        user.setFans(num + 1);
        update(user);
    }

    @Override
    @Transactional
    public void fansNumCutOne(Integer userId) {
        User user = getById(userId);
        Integer num = user.getFans();
        if (num == null) {
            num = 0;
        }
        num = num - 1;
        if (num < 0) {
            num = 0;
        }
        user.setFans(num);
        update(user);
    }


}
package com.bluemobi.decor.portal.util;

import com.qiniu.common.QiniuException;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.FileInfo;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * 七牛图片操作类
 * Created by tuyh on 2015/7/31.
 */
public class UploadUtils {

    // 七牛access_key
    public final static String ACCESS_KEY = "n11CNNYisy7zlx968nsUukE5SmKU7xteiANcdufl";
    // 七牛select_key
    public final static String SECRET_KEY = "6wAV2OyBCq_CSSNTUGbc537qYGPPSyvDNLlRWjbf";
    // 七牛图片空间名
    public final static String bucket = "images";
    // 空间uhoem-face-test的默认域名
    public final static String domain = "http://7xksl1.com2.z0.glb.qiniucdn.com/";

    public static void main(String[] args) throws QiniuException {
        Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
        BucketManager bucketManager = new BucketManager(auth);

        File file = new File("E:/aa.jpg");
        System.out.println("上传的图片路径：" + domain + uploadFile(file));

        // 测试获取空间名列表
        //findBuckets(bucketManager);

        // 测试获取控件下的文件列表
        List<FileInfo> list = getFilesList(bucketManager, bucket);
        for (FileInfo fileInfo : list) {
            System.out.println(fileInfo.key);
        }
    }

    /**
     * 将二进制流格式的文件转换为File格式的文件
     *
     * @param file
     * @return
     */
    public static File changeFile(MultipartFile file) {
        CommonsMultipartFile cf = (CommonsMultipartFile) file;
        DiskFileItem fi = (DiskFileItem) cf.getFileItem();
        File files = fi.getStoreLocation();
        return files;
    }

    /**
     * 将二进制流格式的文件复制一个到指定路径，然后读取
     *
     * @param file
     * @return
     */
    public static File zhFile(MultipartFile file, ServletRequest request) {

        InputStream inputStream = null;
        try {
            inputStream = file.getInputStream();
            File theFile = new File(PathUtils.getWebPath(request) + "excle/excle.xlsx"); //生成的
            FileUtils.copyInputStreamToFile(inputStream, theFile);
            return theFile;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;


    }

    /**
     * 将二进制流格式的文件复制一个到指定路径，然后读取
     *
     * @param file
     * @return
     */
    public static File zhZipFile(MultipartFile file, ServletRequest request) {

        InputStream inputStream = null;
        try {
            inputStream = file.getInputStream();
            File theFile = new File(PathUtils.getWebPath(request) + "zip/daoru.zip"); //生成的
            FileUtils.copyInputStreamToFile(inputStream, theFile);
            return theFile;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;


    }

    /**
     * 上传文件
     *
     * @param file 要上传的文件
     * @return
     */
    public static String uploadMultipartFile(MultipartFile file) {
        UploadManager uploadManager = new UploadManager();
        Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
        String token = auth.uploadToken(bucket, null, 3600, null, true);

        try {
            com.qiniu.http.Response r = uploadManager.put(changeFile(file), null, token, null, null, false);
            StringMap map = r.jsonToMap();
            String key = map.get("key") + "";
            String path = domain + key;
            return path;
        } catch (QiniuException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 上传文件
     *
     * @param file 要上传的文件
     * @return
     */
    public static String uploadFile(File file) {
        UploadManager uploadManager = new UploadManager();
        Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
        String token = auth.uploadToken(bucket, null, 3600, null, true);

        com.qiniu.http.Response r = null;

        try {
            r = uploadManager.put(file, null, token, null, null, false);
            StringMap map = r.jsonToMap();
            return domain + map.get("key") + "";
        } catch (QiniuException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 获取空间名列表
     *
     * @param bucketManager 空间管理类
     * @return
     * @throws com.qiniu.common.QiniuException
     */
    public static String[] findBuckets(BucketManager bucketManager) throws QiniuException {
        String[] buckets = bucketManager.buckets();
        return buckets;
    }

    /**
     * 批量获取文件列表
     *
     * @param bucketManager 空间管理类
     * @param bucket        空间名
     * @return
     */
    public static List<FileInfo> getFilesList(BucketManager bucketManager, String bucket) {
        BucketManager.FileListIterator it = bucketManager.createFileListIterator(bucket, "", 100, null);

        List<FileInfo> list = new ArrayList<FileInfo>();

        while (it.hasNext()) {
            FileInfo[] items = it.next();
            if (items.length >= 1) {
                list.add(items[0]);
            }
        }

        return list;
    }

    /**
     * 查看文件属性
     *
     * @param key 文件key（文件名）
     * @return
     */
    public static FileInfo getFile(String key) {
        FileInfo info = null;
        try {
            Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
            BucketManager bucketManager = new BucketManager(auth);

            info = bucketManager.stat(bucket, key);
        } catch (QiniuException e) {
            e.printStackTrace();
        }
        return info;
    }

    /**
     * 复制文件
     *
     * @param bucket       空间名
     * @param key          文件key（文件名）
     * @param targetBucket 目标空间名
     * @param targetKey    目标文件key（目标文件名）
     */
    public static void copyFile(String bucket, String key, String targetBucket, String targetKey) {
        try {
            Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
            BucketManager bucketManager = new BucketManager(auth);

            bucketManager.copy(bucket, key, targetBucket, targetKey);
        } catch (QiniuException e) {
            e.printStackTrace();
        }
    }

    /**
     * 重命名文件
     *
     * @param key    文件key（文件名）
     * @param newKey 新文件key（新文件名)
     */
    public static void renameFile(String key, String newKey) {
        try {
            Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
            BucketManager bucketManager = new BucketManager(auth);

            bucketManager.rename(bucket, key, newKey);
        } catch (QiniuException e) {
            e.printStackTrace();
        }
    }

    /**
     * 移动文件
     *
     * @param bucket       空间名
     * @param key          文件key（文件名）
     * @param targetBucket 目标空间名
     * @param targetKey    目标文件key（目标文件名）
     */
    public static void moveFile(String bucket, String key, String targetBucket, String targetKey) {
        try {
            Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
            BucketManager bucketManager = new BucketManager(auth);

            bucketManager.move(bucket, key, targetBucket, targetKey);
        } catch (QiniuException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除文件
     *
     * @param key 文件key（文件名）
     * @return
     */
    public static void deleteFile(String key) {
        try {
            if (StringUtils.isNotEmpty(key) && !key.replace(domain, "").trim().equals("")) {
                Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
                BucketManager bucketManager = new BucketManager(auth);

                bucketManager.delete(bucket, key.replace(domain, ""));
            }
        } catch (QiniuException e) {
            e.printStackTrace();
        }
    }
}

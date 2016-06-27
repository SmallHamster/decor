package com.bluemobi.decor.portal.util;



import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * Created by gaoll on 2014/12/16.
 */
public class MsgSmsUtil {

    /**
     * 服务http地址
     */
    private static String URI_SEND_SMS = "http://106.ihuyi.cn/webservice/sms.php";

    /**
     * 密码
     */
    private static String password1 ="269396";


    /**
     * api接口
     */
//    private final static String account = "cf_junvb27";
    private final static String account = "cf_decor";


    /**
     * 编码格式
     */
    private static String ENCODING = "UTF-8";


    /**
     *
     * @return
     * @throws java.io.IOException
     */
    public static String sendSms( String mobile, String content) throws IOException{
       // Map<String,String> params= new HashMap<String,String>();
//        params.put("userid", "1485");
        //params.put("method", "Submit");
       //params.put("account", account);
        //params.put("password", password);
        //params.put("mobile", mobile);
        //params.put("content", content);
        String params = "method=Submit&account="+account+"&password="+password1+"&mobile="+mobile+"&content="+content+"";
//        params.put("sendTime", "");
//        params.put("action", "send");
//        params.put("extno", "");
        return HttpUtils.sendPost4String1(URI_SEND_SMS,params);
    }


    public static String getVerCode(int length){
        StringBuilder sb = new StringBuilder();
        for(int i=0;i<length;i++){
            sb.append(new Random().nextInt(10));
        }
        return sb.toString();
    }


    public static void main(String[] args) {
        try {
            String result = MsgSmsUtil.sendSms("18717101121", "【华科Decor】您的验证码为12355。(请勿告知他人)");
            System.out.println(result);
        }catch (Exception e){
            e.printStackTrace();
        }

    }



}

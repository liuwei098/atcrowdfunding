package com.yc.atcrowdfunding.alipay;

import java.io.FileWriter;
import java.io.IOException;



public class AlipayConfig {
	


	
	public static String app_id = "2016092900620294";
	

    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIB"
    		+ "AQCxvNlKl9toFyHxHnz/nYqIWrFuQ6EWjTxLj6ZEg+iT/iLqyx3BJu51tj2/JAQa3NFrTVWuoEhAowJ6UYBDv8IlFx"
    		+ "dBGO8rIu4Sobf7QE/e9mg04RC/xXT406xL28MAvHKWaJ+8MzJ80z3Y6oBv1d9wvhwLTdHxdYwq9Zf41bvhX4NTr+ApmM/Elj+"
    		+ "7IWXW+qXmOL238c42+OPzflZjhQbQE6q+4qAYEB+0IKXG67isglBWHQ2OYiWSbNyIJd+JRx+CfaGz8O0ITtSr1SceqWOVyHlzcj"
    		+ "iRIMSgDChZq9fqNsSOE8/x3IiMyfHNME/LeGu/cp8ElWZrvdcow78nkOCLAgMBAAECggEANAInry0ada33L6AVQZLu25F2Q+akN34"
    		+ "ie5XQOFJE9zExNHU1ArUKqAUoskqurNGasgRSIyQhoFBSxEoe9zQgckv8cP8D1SKGeYs609lwxbRir75/8S2tWbZOv2/R8uAxw5Nf0m"
    		+ "lEx8PkYBnWdWMm2821VRVzbm1QE64Dxzt7m6mjYyykWLXA798DOH8dfFS7ohY9PiSdLV3Lzn1Rn3HVZQsDhnJQAJJ8T1IEu/WxJzpxch+"
    		+ "jTRcMFPuPsrqP3Jlm475sAT+R6stb+tgsEg+w03/chk6W2W79lAzlem5RN9/7J/tzLctAiP6xCq+WTHCOllKOl3zps1fCRuzXqtUjwQKBg"
    		+ "QDXnNPb1sNuX46qTnP3Fl/FtzHq3dEo9syukd7je5mqtgrLp7odEkYXcWQD4yDS5ho11O+dl7Ch7u3/FJB0Up5JJmbNv10YVaUgtmFYsTbp"
    		+ "UnziAw27UCHSolIuBc8sbwTCxgnxhUy2R6HTvldqlI4Js+37M8Gw0gS21UG7R5eHYQKBgQDTB9KcrLn+CmbX3uPKk4+6wS1Af5FPPcG+zw"
    		+ "8Wdwt0JT4dQ/XzsUSiUIJLi/LFPmi8PMmsFEwtXI/gWCyNTjex/oUEQfSw+8zXZgZzJ7M8liHLZHGAtggTeH5uy8uItCQR4ZTAyQpInzi5N"
    		+ "lAUDpNpalmMp2/18NkaXP9lvj4rawKBgGmIBBYM5vjF4qEu5wmgNN4kDVWknjRLn+Et2odDPvJUSbJmdOy3vgDJaieQ6sbvAxMoFuPuk"
    		+ "/CebnS0TwPwUDMDjbvUly9K9Bivy7PKgVLwIdnJntX4oaVj9485Hq7j49OldMZ29RYet3FZL5YmAeNz4t5Z9cqi8NXASXztzJfhAoGBAM"
    		+ "EdRoGzmty8HhLr2F64HG5Vexir5Ii0RglbqD3xoJyfvDDB0WA5V0qGDEYgAoC3tNaVdiQvyuoz60HszpBdBKCw/n6/8LDJLFHs/ngA24f"
    		+ "VB4X+G9QiQE+5E1JG0rH9z4hBe4PUNcHxWtI6vpssH3/3H42UZ+OTjMkQU3OC3ZeTAoGAdF1nVfsB1Frs9MMLXauDzasCQc6XROB6u8VDo"
    		+ "XfQ+mmh3gfHufkrte0kRzDpaq/7yxs0MheoBAksVVUmEpQPIj0fSEA+ycVCBEZInf7YCR6Fl9kO/9MUsuA4sHBKjDBrBtltemVVRN8tVOA"
    		+ "Ph7SP1qsDtd0Oeix1haVFAhP2iI4=";
	
	
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhijKXGNg1cpF4wkcr"
    		+ "l9b9pSeklHv251yc09zx9a7n4/3N2SQ6Q/raB+VFb/QCsU9T8JGzWkGtFDMb85ZEJ1/vZx7ppdsZlzjeNtVrE9BKRbtah"
    		+ "61AQcSL51H8G+OxtlOahaDqV8Xs/a1jvFmiHWECk2kzq7F7iad4GqRQcAQDMsNxAu7fLFa7s03YFvLEQz3FInA3dAeaT9"
    		+ "OBrJA3Np2gsWCUH+Fplwtn1/cMQt3V4UaBZE0uyD255wwYZLMkNn6x0LN1RUjesvg09NIo9tovcdjoYT5CbQj4Mfk9sj8"
    		+ "rR2jHaZPJ0Z543f78Qov+strj2+/XHNhSX2+gOeEiTuI+wIDAQAB";


	public static String notify_url = "http://39.107.238.190/notify_url";

	
	public static String return_url = "http://39.107.238.190/return_url";

	
	public static String sign_type = "RSA2";
	
	
	public static String charset = "utf-8";
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	
	
	public static String log_path = "D:\\";



    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}


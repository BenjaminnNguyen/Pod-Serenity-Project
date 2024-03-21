package cucumber.singleton;

import java.util.ArrayList;

public class GVs {

    public static String ENVIRONMENT = "default";
    public static String ENVIRONMENT_BASEURI;
    public static final int HTTP_TIMEOUT = 45;

    public static final int SHORT_TIMEOUT = 5;

    public static String VALIDATE_INPUT_FILE_PATH = "src/test/resources/files/api/";
    public static String PATH_ADMIN = "src/test/resources/files/api/admin/";
    public static String FILE_PATH_IMAGE = "src/test/resources/files/Images/";

    public static String WINDOWN_HANDLE;

    /**
     * Data String
     */

    public static final String STRING_1K = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";
    public static final String STRING_300 = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";

    /**
     * URL WEB BETA CHUẨN
     */
//    public static final String URL_BETA = "https://beta.podfoods.co/";
//    public static final String URL_ADMIN = "https://adminbeta.podfoods.co/";
//    public static final String URL_APIBETA = "https://apibeta.podfoods.co/admin/login";
//    public static final String URL_LP = "https://lp.beta.podfoods.co/";

    /**
     * URL WEB AUTO TEST
     */
    public static final String URL_BETA = "https://auto.podfoods.co/";
    public static final String URL_ADMIN = "https://adminauto.podfoods.co/";
    public static final String URL_APIBETA = "https://apiauto.podfoods.co/admin/login";
    public static final String URL_LP = "https://lp.auto.podfoods.co/";
    public static final String URL_SLACK = "https://podfoods.slack.com/";

    public static final String URL_FLOWSPACE = "https://app.flowspace.dev/users/sign_in/";

//    /**
//     * URL WEB DEV TEST
//     */
//    public static final String URL_BETA = "https://dev.podfoods.co/";
//    public static final String URL_ADMIN = "https://admindev.podfoods.co/";
//    public static final String URL_APIBETA = "https://apibeta.podfoods.co/admin/login";
//    public static final String URL_LP = "https://lp.dev.podfoods.co/";
//    public static final String URL_SLACK = "https://podfoods.slack.com/";
//    public static final String URL_FLOWSPACE = "https://app.flowspace.dev/users/sign_in/";

    /**
     * URL API
     */
//    public static final String BETA = "https://apibeta.podfoods.co/";
    public static final String BETA = "https://apiauto.podfoods.co/";
//    public static final String BETA = "https://apidev.podfoods.co/";

    /**
     * Tên user
     */
    public enum AccountType {
        THUYEXAM,
        ADMIN,
        BAO_ADMIN, BAO_ADMIN2, BAO_ADMIN3, BAO_ADMIN4, BAO_ADMIN5, BAO_ADMIN6, BAO_ADMIN7, BAO_ADMIN8,
        BAO_ADMIN9, BAO_ADMIN10, BAO_ADMIN11, BAO_ADMIN12, BAO_ADMIN13, BAO_ADMIN14, BAO_ADMIN15, BAO_ADMIN16,
        BAO_ADMIN17, BAO_ADMIN18, BAO_ADMIN19, BAO_ADMIN20, BAO_ADMIN21, BAO_ADMIN22, BAO_ADMIN23, BAO_ADMIN24, BAO_ADMIN25,
        BAO_ADMIN26, BAO_ADMIN27, BAO_ADMIN28, BAO_ADMIN29, BAO_ADMIN30,
        NGOC_ADMIN,
        NGOC_ADMIN_01,
        NGOC_ADMIN_02,
        NGOC_ADMIN_03,
        NGOC_ADMIN_04,
        NGOC_ADMIN_05,
        NGOC_ADMIN_05A,
        NGOC_ADMIN_06,
        NGOC_ADMIN_07,
        NGOC_ADMIN_08,
        NGOC_ADMIN_09,
        NGOC_ADMIN_10,
        NGOC_ADMIN_11,
        NGOC_ADMIN_12,
        NGOC_ADMIN_13,
        NGOC_ADMIN_14,
        NGOC_ADMIN_15,
        NGOC_ADMIN_16,
        NGOC_ADMIN_17,
        NGOC_ADMIN_18,
        NGOC_ADMIN_19,
        NGOC_ADMIN_20,
        NGOC_ADMIN_21,
        NGOC_ADMIN_22,
        NGOC_ADMIN_23,
        NGOC_ADMIN_24,
        NGOC_ADMIN_25,
        NGOC_BUYER_CHICAGO1,
        NGOC_BUYER_NY1,
        VENDOR,
        BUYER,
        NGOC_SLACK
    }
}

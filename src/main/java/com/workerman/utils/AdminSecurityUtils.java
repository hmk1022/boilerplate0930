package com.workerman.utils;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.workerman.vo.AdminVo;

@Component
public final class AdminSecurityUtils {

    public static final String SESSION_ADMIN_KEY = "_session_admin_key";


    public static boolean isAuthenticated() {
        return getAdmin() != null;
    }


    /**
     * Get the login of the current member.
     *
     * @return the login of the current member
     */
    public static AdminVo getCurrentUser() {
        return getAdmin();
    }


    /**
     * Get the login of the current member.
     *
     * @return the login of the current member
     */
    public static void setCurrentUser(AdminVo admin) {
        setAdmin(admin);
    }


    public static void removeCurrentUser() {
        RequestContextHolder.getRequestAttributes().removeAttribute(SESSION_ADMIN_KEY, RequestAttributes.SCOPE_SESSION);
    }

    private static AdminVo getAdmin() {
        if(RequestContextHolder.getRequestAttributes() == null) {
            return null;
        }
        return (AdminVo) RequestContextHolder.getRequestAttributes().getAttribute(SESSION_ADMIN_KEY, RequestAttributes.SCOPE_SESSION);
    }

    private static void setAdmin(AdminVo admin) {
        RequestContextHolder.getRequestAttributes().setAttribute(SESSION_ADMIN_KEY, admin, RequestAttributes.SCOPE_SESSION);
    }
}

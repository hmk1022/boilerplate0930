package com.workerman.config;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import com.workerman.service.JwtTokenService;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.SignatureException;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

	@Autowired
	private JwtTokenService jwtTokenService;

	@Override
	protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		
		String header = req.getHeader(Constants.HEADER_STRING);
		String adminId = null;
		String adminName = null;
		Long adminNo = null;
		String memberId = null;
		Long memberNo = null;
		String authToken = null;
		
		boolean gotoHome = false;
		
		if (header != null && header.startsWith(Constants.TOKEN_PREFIX)) {
			authToken = header.replace(Constants.TOKEN_PREFIX, "");
			try {
				adminId = jwtTokenService.getAdminIdFromToken(authToken);
				adminNo = jwtTokenService.getAdminNoFromToken(authToken);
				adminName = jwtTokenService.getAdminNameFromToken(authToken);
				
				memberId = jwtTokenService.getMemberIdFromToken(authToken);
				memberNo = jwtTokenService.getMemberNoFromToken(authToken);
			} catch (IllegalArgumentException e) {
				logger.error("an error occured during getting username from token", e);
			} catch (ExpiredJwtException e) {
				logger.warn("the token is expired and not valid anymore", e);
			} catch (SignatureException e) {
				logger.error("Authentication Failed. Username or Password not valid.");
			}
		} else {
			logger.warn("couldn't find bearer string, will ignore the header");
			gotoHome = true;
		}
		
		if (memberId != null && SecurityContextHolder.getContext().getAuthentication() == null) {

			req.setAttribute("member_no", memberNo);
			req.setAttribute("member_id", memberId);

			if (jwtTokenService.validateTokenMember(authToken)) {
				
				UserDetails user = new User(memberId, memberNo+"", getAuthority());
				
				UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null,
						Arrays.asList(new SimpleGrantedAuthority("ROLE_USER")));
				authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
				logger.info("authenticated user " + memberId + ", setting security context");
				SecurityContextHolder.getContext().setAuthentication(authentication);
			}
			
		} else if (adminId != null && SecurityContextHolder.getContext().getAuthentication() == null) {

			req.setAttribute("admin_no", adminNo);
			req.setAttribute("admin_id", adminId);
			req.setAttribute("admin_name", adminName);

			if (jwtTokenService.validateTokenAdmin(authToken)) {
				
				UserDetails user = new User(adminId, adminNo+"", getAuthority());
				
				UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user,
						null, Arrays.asList(new SimpleGrantedAuthority("ROLE_USER")));
				authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
				logger.info("authenticated admin " + adminId + ", setting security context");
				SecurityContextHolder.getContext().setAuthentication(authentication);
			}
			
		} else {
			//res.sendRedirect("/");
//			req = new HttpServletRequestWrapper((HttpServletRequest) req) {
//                @Override
//                public String getRequestURI() {
//                    return "/";
//                }
//            };
			
//			if(gotoHome) {
//				((HttpServletResponse)res).sendRedirect("/login");
//			}
			
		}
		
		chain.doFilter(req, res);
	}
	
	private List<SimpleGrantedAuthority> getAuthority() {
		return Arrays.asList(new SimpleGrantedAuthority("ROLE_SELLER"));
	}
}
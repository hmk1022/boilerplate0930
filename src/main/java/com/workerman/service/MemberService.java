package com.workerman.service;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.workerman.commons.CommonCode;
import com.workerman.dao.CommonDao;
import com.workerman.utils.StringUtil;
import com.workerman.utils.Utils;
import com.workerman.vo.MemberInfoDataItemVo;
import com.workerman.vo.MemberInfoDataVo;
import com.workerman.vo.MemberInfoReqVo;
import com.workerman.vo.MemberInfoResVo;
import com.workerman.vo.MemberInfoUpdateReqVo;
import com.workerman.vo.MemberJoinReqVo;
import com.workerman.vo.MemberLoginReqVo;
import com.workerman.vo.MemberLoginResDataVo;
import com.workerman.vo.MemberLoginResVo;
import com.workerman.vo.MemberPasswordUpdateReqVo;
import com.workerman.vo.PasswordResetReqVo;
import com.workerman.vo.PasswordUpdateReqVo;
import com.workerman.vo.ResultVo;

import net.sf.json.JSONException;

@Service("memberService")
public class MemberService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;

	@Autowired
	private JwtTokenService jwtTokenService;

	@Autowired
	private EmailService emailService;

	/**
	 * 로그인처리
	 * @param memberLoginReqVo
	 * @return
	 * @throws NoSuchAlgorithmException 
	 * @throws JSONException 
	 */
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED, rollbackFor=Exception.class)
	public MemberLoginResVo login(MemberLoginReqVo memberLoginReqVo) throws Exception {

		MemberLoginResVo memberLoginResVo = new MemberLoginResVo();

		Map<String, Object> member = commonDao.queryForObject("member.selectMember", Utils.objectToMap(memberLoginReqVo));

		if(isEmpty(member)) { // 회원정보없음
			memberLoginResVo.setErrorCode(CommonCode.RETURN_FAIL_EMPTY_MEMBER.getCode(), CommonCode.RETURN_FAIL_EMPTY_MEMBER.getMessage());
		}
		else if(!StringUtil.equals(StringUtil.stringToMd5(memberLoginReqVo.getPassword()), (String)member.get("password"))){
			memberLoginResVo.setErrorCode(CommonCode.RETURN_FAIL_AUTH_PW.getCode(), CommonCode.RETURN_FAIL_AUTH_PW.getMessage());
		}
		else {

//			if(isEmpty(memberLoginReqVo.getPassword())) { // 자체가입인데 패스워드누락
//				memberLoginResVo.setErrorCode(CommonCode.RETURN_FAIL_INVALID_INPUT.getCode(), CommonCode.RETURN_FAIL_INVALID_INPUT.getMessage());
//				return memberLoginResVo;
//			}

//			if(!bcryptEncoder.matches(memberLoginReqVo.getPassword(), member.get("password").toString())) { // 패스워드 불일치
//				memberLoginResVo.setErrorCode(CommonCode.RETURN_FAIL_AUTH_PW.getCode(), CommonCode.RETURN_FAIL_AUTH_PW.getMessage());
//				return memberLoginResVo;
//			}


//			로그인 시간 체크.
//			commonDao.update("member.updateMemberLoginDate", member);

			List<Map<String, Object>> member_role = commonDao.queryForList("member.selectMemberRole", Utils.objectToMap(memberLoginReqVo));

			if(member_role == null) {
				System.out.println("# 할당된 권한이 없습니다.!!!!");
				memberLoginResVo.setErrorCode(CommonCode.RETURN_FAIL_AUTH_EMPTY.getCode(), CommonCode.RETURN_FAIL_AUTH_EMPTY.getMessage());
			} else {
				System.out.println("# 할당된 권한이 있습니다.!!!!");
			}

			long member_no = Utils.getLong(member.get("admin_no").toString());

			String token = jwtTokenService.doGenerateTokenAdmin(
					Utils.getLong(member.get("admin_no").toString()),
					member.get("admin_id").toString(),
					member.get("admin_name").toString(),
					member_role
				);

			MemberLoginResDataVo memberLoginResDataVo = new MemberLoginResDataVo();
			memberLoginResDataVo.setActivity_new_cnt(commonDao.queryForInt("activity.selectActivityNewCnt", member));
			memberLoginResDataVo.setMember_no(member_no);
			memberLoginResDataVo.setToken(token);

			memberLoginResVo.setErrorNone();
			memberLoginResVo.setResult_data(memberLoginResDataVo);

		}

		return memberLoginResVo;

	}


	/**
	 * 회원정보조회
	 * @param memberInfoReqVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMemberInfo(MemberInfoReqVo memberInfoReqVo, HttpServletRequest request) throws Exception{
		memberInfoReqVo.setMember_no(Long.parseLong(request.getAttribute("admin_no").toString())); // 회원번호주입
		return commonDao.queryForObject("member.selectMemberInfo", Utils.objectToMap(memberInfoReqVo));
	}
	
	/**
	 * 회원정보조회
	 * @param memberInfoReqVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMemberInfo(Long admin_no) throws Exception{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("member_no", admin_no);
		return commonDao.queryForObject("member.selectMemberInfo", param);
	}
}

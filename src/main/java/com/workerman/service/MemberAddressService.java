package com.workerman.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.AddressAddReqVo;
import com.workerman.vo.AddressDeleteReqVo;
import com.workerman.vo.AddressListDataVo;
import com.workerman.vo.AddressListReqVo;
import com.workerman.vo.AddressListResVo;
import com.workerman.vo.AddressListVo;
import com.workerman.vo.AddressUpdateReqVo;
import com.workerman.vo.ResultVo;

@Service("memberAddressService")
public class MemberAddressService extends BaseService {

	@Autowired
	private CommonDao commonDao;

	/**
	 * 내주소목록
	 * @param addressListReqVo
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public AddressListResVo selectMemberAddressList(AddressListReqVo addressListReqVo, HttpServletRequest request){
		
		addressListReqVo.setMember_no(Long.parseLong(request.getAttribute("member_no").toString())); // 회원번호주입
		
		AddressListResVo addressListResVo = new AddressListResVo();
		
		List<AddressListDataVo> list = commonDao.queryForList("memberAddress.selectMemberAddressList", Utils.objectToMap(addressListReqVo));
		
		AddressListVo addressListVo = new AddressListVo();
		
		addressListVo.setList(list);
				
		addressListResVo.setErrorNone();
		
		addressListResVo.setResult_data(addressListVo);
		
		return addressListResVo;
	}
	
	/**
	 * 주소등록
	 * @param addressAddReqVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public ResultVo insertMemberAddress(AddressAddReqVo addressAddReqVo, HttpServletRequest request) throws Exception{
		
		ResultVo resultVo = new ResultVo();
		
		addressAddReqVo.setMember_no(Long.parseLong(request.getAttribute("member_no").toString())); // 회원번호주입
		
		commonDao.insert("memberAddress.insertMemberAddress", Utils.objectToMap(addressAddReqVo));

		resultVo.setErrorNone();
		
		return resultVo;
	}
	
	/**
	 * 주소변경
	 * @param addressUpdateReqVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public ResultVo updateMemberAddress(AddressUpdateReqVo addressUpdateReqVo, HttpServletRequest request) throws Exception{
		
		ResultVo resultVo = new ResultVo();
		
		addressUpdateReqVo.setMember_no(Long.parseLong(request.getAttribute("member_no").toString())); // 회원번호주입
		
		commonDao.insert("memberAddress.updateMemberAddress", Utils.objectToMap(addressUpdateReqVo));

		resultVo.setErrorNone();
		
		return resultVo;
	}
	
	/**
	 * 주소삭제
	 * @param addressDeleteReqVo
	 * @return
	 * @throws Exception
	 */
	public ResultVo deleteAddress(AddressDeleteReqVo addressDeleteReqVo) throws Exception{
		
		ResultVo resultVo = new ResultVo();
		
		commonDao.delete("memberAddress.deleteMemberAddress", Utils.objectToMap(addressDeleteReqVo));

		resultVo.setErrorNone();
		
		return resultVo;
	}
	
	
	
	
}

package com.workerman.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.ChatHistListVo;
import com.workerman.vo.ChatHistReqVo;
import com.workerman.vo.ChatHistResVo;
import com.workerman.vo.ChatMsgAddReqVo;
import com.workerman.vo.ChatMsgDataVo;
import com.workerman.vo.ChatMsgReqVo;
import com.workerman.vo.ChatMsgResVo;
import com.workerman.vo.ResultVo;

@Service("chatService")
public class ChatService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 멘트내용요청
	 * @param chatMsgReqVo
	 * @param request
	 * @return
	 */
	public ChatMsgResVo reqChatMsg(ChatMsgReqVo chatMsgReqVo, HttpServletRequest request) {
		
		chatMsgReqVo.setMember_no(Long.parseLong(request.getAttribute("member_no").toString())); // 회원번호주입
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("member_no", chatMsgReqVo.getMember_no());
		param.put("ment_no", null);
		param.put("msg", chatMsgReqVo.getMsg());
		param.put("msg_type", 0); // 메시지유형 - 0:일반텍스트메시지 1:이미지 10:인사메시지 20:서비스특징 30:작업가능분야 40:고객센터 50:오시는길
		param.put("img_path", null);
		param.put("req_yn", "Y"); // 요청메시지여부 Y:요청메시지 N:응답메시지
		
		commonDao.insert("aiChatHist.insertAiChatHist", param);	// 요청문구이력등록
		
		ChatMsgResVo chatMsgResVo = new ChatMsgResVo();
		
		ChatMsgDataVo chatMsgDataVo = (ChatMsgDataVo)commonDao.queryForObjectNoCast("aiMent.selectAiMent", Utils.objectToMap(chatMsgReqVo));
		
		chatMsgResVo.setResult_data(chatMsgDataVo);

		if(chatMsgResVo.getResult_data() != null) { // 응답문구가 있을때
			
			param.clear();
			param.put("member_no", chatMsgReqVo.getMember_no());
			param.put("ment_no", chatMsgDataVo.getMent_no());
			param.put("msg", chatMsgDataVo.getMsg());
			param.put("msg_type", 0); // 메시지유형 - 0:일반텍스트메시지 1:이미지 10:인사메시지 20:서비스특징 30:작업가능분야 40:고객센터 50:오시는길
			param.put("img_path", null);
			param.put("req_yn", "N"); // 요청메시지여부 Y:요청메시지 N:응답메시지
			
			commonDao.insert("aiChatHist.insertAiChatHist", param);	// 응답문구이력등록
		}
		
		chatMsgResVo.setErrorNone();
		
		return chatMsgResVo;
	}
	
	/**
	 * 대화이력목록
	 * @param chatHistReqVo
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ChatHistResVo getHistList(ChatHistReqVo chatHistReqVo, HttpServletRequest request) {
		
		chatHistReqVo.setMember_no(Long.parseLong(request.getAttribute("member_no").toString())); // 회원번호주입
		
		ChatHistResVo chatHistResVo = new ChatHistResVo();
		
		ChatHistListVo chatHistListVo = new ChatHistListVo();
		
		chatHistListVo.setList(commonDao.queryForList("aiChatHist.selectAiChatHistList", Utils.objectToMap(chatHistReqVo)));
		
		chatHistResVo.setResult_data(chatHistListVo);
		
		chatHistResVo.setErrorNone();
		
		return chatHistResVo;
		
	}
	
	/**
	 * 대화이력등록
	 * @param chatMsgAddReqVo
	 * @return
	 */
	public ResultVo addChatMsgHist(ChatMsgAddReqVo chatMsgAddReqVo, HttpServletRequest request) {
		
		chatMsgAddReqVo.setMember_no(Long.parseLong(request.getAttribute("member_no").toString())); // 회원번호주입
		
		ResultVo resultVo = new ResultVo();
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("member_no", chatMsgAddReqVo.getMember_no());
		param.put("ment_no", null);
		param.put("msg", chatMsgAddReqVo.getMsg());
		param.put("msg_type", chatMsgAddReqVo.getMsg_type()); // 메시지유형 - 0:일반텍스트메시지 1:이미지 10:인사메시지 20:서비스특징 30:작업가능분야 40:고객센터 50:오시는길
		param.put("img_path", null);
		param.put("req_yn", chatMsgAddReqVo.getReq_yn()); // 요청메시지여부 Y:요청메시지 N:응답메시지
		
		commonDao.insert("aiChatHist.insertAiChatHist", param);	// 요청문구이력등록
		
		resultVo.setErrorNone();
		
		return resultVo;
		
	}
	
}

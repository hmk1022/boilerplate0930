package com.workerman.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workerman.dao.CommonDao;
import com.workerman.utils.Utils;
import com.workerman.vo.BoardListVo;
import com.workerman.vo.BoardReqVo;
import com.workerman.vo.BoardResVo;

@Service("boardService")
public class BoardService extends BaseService {

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 공지사항목록
	 * @param boardReqVo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public BoardResVo noticeList(BoardReqVo boardReqVo){
		
		BoardResVo boardResVo = new BoardResVo();
		
		BoardListVo boardListResVo = new BoardListVo(); 
		
		//01:안드 02:아이폰 03:공통
		if(boardReqVo.getOs_type().equals("A")) {
			boardReqVo.setOs_type("01,03");
		}else {
			boardReqVo.setOs_type("02,03");
		}
		
		boardListResVo.setList(commonDao.queryForList("board.selectBoardList", Utils.objectToMap(boardReqVo)));
		
		boardResVo.setResult_data(boardListResVo);
		
		boardResVo.setErrorNone();
		
		return boardResVo;
	}
	
	
	
}

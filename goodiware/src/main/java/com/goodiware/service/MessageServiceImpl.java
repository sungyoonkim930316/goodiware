package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.MessageMapper;
import com.goodiware.vo.Message;

@Service("messageService")
public class MessageServiceImpl implements MessageService {

	@Autowired
	MessageMapper messageMapper;

	@Override
	public void sendMessage(Message message) {
		
		message.setReceiver(messageMapper.selectEmployeeNoById(message.getReceiveid()));
		
		messageMapper.insertMessage(message);
		
	}

	@Override
	public List<Message> showMessages(int empno) {
		
		return messageMapper.selectMessage(empno);
	}

	@Override
	public Message showContent(int mno) {
		
		return messageMapper.selectMessageContent(mno);
	}

	@Override
	public void updateReadDate(int mno) {

		messageMapper.insertOpenDate(mno);
	}

	@Override
	public void trashMessage(int mno) {

		messageMapper.updateMessage(mno);
	}

	@Override
	public List<Message> showTrashMessage(int empno) {
		
		return messageMapper.selectTrashMessages(empno);
	}

	@Override
	public void deleteMessage(int mno) {
		
		messageMapper.deleteMessage(mno);
	}

	@Override
	public int lookupOpendate(int empno) {
		
		return messageMapper.selectOpendateCount(empno);
	}

	@Override
	public int trashCount(int empno) {

		return messageMapper.selectDeleteCount(empno);
	}

	@Override
	public void resotreMessage(int mno) {

		messageMapper.updateRestoreMessage(mno);
	}

	@Override
	public String searchSendId(int sender) {
		
		return messageMapper.selectSendId(sender);
	}

	@Override
	public List<Message> showMessagesByMe(int empno) {

		return messageMapper.selectSendMessageByMe(empno);
	}

	@Override
	public Message sendMessageContent(int mno) {

		return messageMapper.sendMessageContent(mno);
	}

	@Override
	public List<Message> findMessageWithPaging(HashMap<String, Object> params) {

		return messageMapper.selectMessageWithPaging(params);
	}

	@Override
	public int findMessageCount(HashMap<String, Object> params) {
		
		return messageMapper.selectMessageCountWithpaging(params);
	}

	@Override
	public List<Message> findMessageByMeWithPaging(HashMap<String, Object> params) {

		return messageMapper.selectMessageByMeWithPaging(params);
	}

	@Override
	public int findSendMessageCount(HashMap<String, Object> params) {

		return messageMapper.selectSendMessageCount(params);
	}

	@Override
	public List<Message> findTrashMessageWithPaging(HashMap<String, Object> params) {

		return messageMapper.selectTrashMessageWithPaging(params);
	}

	@Override
	public int findTrashMessageCount(HashMap<String, Object> params) {

		return messageMapper.selectTrashMessageCount(params);
	}

	@Override
	public Message findFileByMno(int mno) {

		return messageMapper.selectFileByMno(mno);
	}

	@Override
	public List<Message> findRecentMessagesByEmpno(int empno) {
		
		return messageMapper.selectRecentMessagesByEmpno(empno);
	}


	

	
}

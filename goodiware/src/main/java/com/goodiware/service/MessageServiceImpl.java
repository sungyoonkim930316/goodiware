package com.goodiware.service;

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


	

	
}

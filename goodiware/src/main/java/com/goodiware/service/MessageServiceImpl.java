package com.goodiware.service;

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
		
		messageMapper.insertMessage(message);
	}
	

	
}

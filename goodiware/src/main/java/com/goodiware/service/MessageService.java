package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.Message;

public interface MessageService {

	void sendMessage(Message message);

	List<Message> showMessages(int empno);

	Message showContent(int mno);

	void updateReadDate(int mno);


}

package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.Message;

public interface MessageService {

	void sendMessage(Message message);

	List<Message> showMessages(int empno);

	Message showContent(int mno);

	void updateReadDate(int mno);

	void trashMessage(int mno);

	List<Message> showTrashMessage(int empno);

	void deleteMessage(int mno);

	int lookupOpendate(int empno);

	int trashCount(int empno);

	void resotreMessage(int mno);

	String searchSendId(int sender);


}

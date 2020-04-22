package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import com.goodiware.vo.Employee;
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

	List<Message> showMessagesByMe(int empno);

	Message sendMessageContent(int mno);

	List<Message> findMessageWithPaging(HashMap<String, Object> params);

	int findMessageCount(HashMap<String, Object> params);

	List<Message> findMessageByMeWithPaging(HashMap<String, Object> params);

	int findSendMessageCount(HashMap<String, Object> params);

	List<Message> findTrashMessageWithPaging(HashMap<String, Object> params);

	int findTrashMessageCount(HashMap<String, Object> params);

	Message findFileByMno(int mno);

	List<Message> findRecentMessagesByEmpno(int empno);

	List<Employee> searchReceiveIdList(String receiveid);


}

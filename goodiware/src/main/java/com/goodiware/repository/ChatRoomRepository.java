package com.goodiware.repository;

import java.util.List;
import java.util.Optional;

import javax.annotation.Resource;

import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Repository;

import com.goodiware.vo.ChatRoom;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class ChatRoomRepository {
	
	// Redis
	private static final String CHAT_ROOMS = "CHAT_ROOM"; // 채팅룸 저장
	// 채팅룸에 입장한 클라이언트 수
	public static final String USER_COUNT = "USER_COUNT"; 
	// 채팅룸에 입장한 클라이언트의 sessionId와 채팅룸 id를 맵핑한 정보 저장
	public static final String ENTER_INFO = "ENTER_INFO"; 
	
	@Resource(name = "redisTemplate")
	private HashOperations<String, String, ChatRoom> hashOpsChatRoom;
	@Resource(name = "redisTemplate")
	private HashOperations<String, String, String> hashOpsEnterInfo;
	@Resource(name = "redisTemplate")
	private ValueOperations<String, String> valueOps;
	 
	// 모든 채팅방 조회
    public List<ChatRoom> findAllRoom() {
    	System.out.println("start function findAllRoom hashOpsChatRoom Value : " + hashOpsChatRoom.values(CHAT_ROOMS));
        return hashOpsChatRoom.values(CHAT_ROOMS);
    }
    
    // 특정 채팅방 조회
    public ChatRoom findRoomById(String id) {
    	System.out.println("start function findRoomById" + " 아이디 : " + id);
        return hashOpsChatRoom.get(CHAT_ROOMS, id);
    }
    
    // 채팅방 생성 : 서버간 채팅방 공유를 위해 redis hash에 저장한다.
    public ChatRoom createChatRoom(String name) {
    	System.out.println("start function createChatRoom" + " 네임 : " + name);
        ChatRoom chatRoom = ChatRoom.create(name);
        hashOpsChatRoom.put(CHAT_ROOMS, chatRoom.getRoomId(), chatRoom);
        return chatRoom;
    }
    
    // 유저가 입장한 채팅방ID와 유저 세션ID 맵핑 정보 저장
    public void setUserEnterInfo(String sessionId, String roomId) {
    	System.out.println("start function setUserEnterInfo" + " 세션아디 : " + sessionId + " 룸아이디  : " + roomId);
        hashOpsEnterInfo.put(ENTER_INFO, sessionId, roomId);
    }
    
    // 유저 세션으로 입장해 있는 채팅방 ID 조회
    public String getUserEnterRoomId(String sessionId) {
    	System.out.println("start function getUserEnterRoomId" + " 세션아디 : " + sessionId);
        return hashOpsEnterInfo.get(ENTER_INFO, sessionId);
    }
    
    // 유저 세션정보와 맵핑된 채팅방ID 삭제
    public void removeUserEnterInfo(String sessionId) {
    	System.out.println("start function removeUserEnterInfo" + " 세션아디 : " + sessionId);
        hashOpsEnterInfo.delete(ENTER_INFO, sessionId);
    }
    
    // 채팅방 유저수 조회
    public long getUserCount(String roomId) {
    	System.out.println("start function getUserCount" + " 룸아디 : " + roomId);
        return Long.valueOf(Optional.ofNullable(valueOps.get(USER_COUNT + "_" + roomId)).orElse("0"));
    }
    
    // 채팅방에 입장한 유저수 +1
    public long plusUserCount(String roomId) {
    	System.out.println("start function plusUserCount" + " 룸아디 : " + roomId);
        return Optional.ofNullable(valueOps.increment(USER_COUNT + "_" + roomId)).orElse(0L);
    }
    
    // 채팅방에 입장한 유저수 -1
    public long minusUserCount(String roomId) {
    	System.out.println("start function minusUserCount" + " 룸아디 : " + roomId);
        return Optional.ofNullable(valueOps.decrement(USER_COUNT + "_" + roomId)).filter(count -> count > 0).orElse(0L);
    }
	
}

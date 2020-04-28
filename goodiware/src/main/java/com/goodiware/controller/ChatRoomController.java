package com.goodiware.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodiware.provider.JwtTokenProvider;
import com.goodiware.repository.ChatRoomRepository;
import com.goodiware.security.GoodiwareUserDetails;
import com.goodiware.vo.ChatRoom;
import com.goodiware.vo.Employee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping(path= {"/chat"})
public class ChatRoomController {

	private final ChatRoomRepository chatRoomRepository;
	private final JwtTokenProvider jwtTokenProvider;
	
	@GetMapping("/room")
	public String rooms(Model model) {
		return "/chat/room";
	}
	
	@GetMapping("/rooms")
	@ResponseBody
	public List<ChatRoom> room() {
		
		List<ChatRoom> chatRooms = chatRoomRepository.findAllRoom();
		chatRooms.stream().forEach(room -> 
		room.setUserCount(chatRoomRepository.getUserCount(room.getRoomId())));
		
		return chatRooms;
		
	}
	
	@PostMapping("/room")
	@ResponseBody
	public ChatRoom createRoom(@RequestParam String name) {
		return chatRoomRepository.createChatRoom(name);
	}
	
	@GetMapping("/room/enter/{roomId}")
	public String roomDetail(Model model, @PathVariable String roomId) {
		
		model.addAttribute("roomId", roomId);
		
		return "/chat/roomdetail";
		
	}
	
	@GetMapping("/room/{roomId}")
	@ResponseBody
	public ChatRoom roomInfo(@PathVariable String roomId) {
		
		return chatRoomRepository.findRoomById(roomId);
		
	}
		
	@GetMapping("/user")
	@ResponseBody
	public Employee getUserInfo() {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		System.out.println("start function getUserInfo auth is : " + auth);
		
		Employee employee = ((GoodiwareUserDetails)auth.getPrincipal()).getEmployee();
					
		String name = employee.getName();

		return Employee.builder().name(name)
				.token(jwtTokenProvider.generateToken(name)).build();
	}
	
}

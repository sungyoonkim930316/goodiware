package com.goodiware.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.goodiware.common.Util;

public class GoodiwarePasswordEncoder implements PasswordEncoder {

	@Override
	public String encode(CharSequence rawPassword) {
		// do nothing for encoding
		return Util.getHashedString(rawPassword.toString(), "SHA-256");
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
				
		boolean valid = encode(rawPassword).equals(encodedPassword);		
		return valid;
	}

}

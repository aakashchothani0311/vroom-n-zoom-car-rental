package com.vroomnzoom.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.vroomnzoom.interceptor.LoginInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	@Autowired
    private LoginInterceptor myInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(myInterceptor)
		        .addPathPatterns("/**")
		        .excludePathPatterns("/css/**", "/js/**", "/images/**");
//		        .addPathPatterns("/sign-up")
//                .addPathPatterns("/bookings/**")
//                .addPathPatterns("/admin/**");
    }
}

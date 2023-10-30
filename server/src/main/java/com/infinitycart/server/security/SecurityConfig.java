package com.infinitycart.server.security;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebSecurity
@EnableWebMvc
public class SecurityConfig {

	 @Bean
	    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
	        return http
	        .csrf(csrf -> csrf.disable()).authorizeHttpRequests(auth -> auth
	                .requestMatchers("**").permitAll()
	                
	            ).cors(t -> t.configurationSource(request -> {
	                CorsConfiguration config = new CorsConfiguration();
	                config.addAllowedOrigin("http://localhost:5173");
	                config.setAllowedMethods(List.of("*")); // You can specify specific HTTP methods
	                config.setAllowedHeaders(List.of("*")); // You can specify specific headers
	                config.setAllowCredentials(true);

	                return config;
	            })).build();
	        
	    }
	
	     @Bean
	     public WebMvcConfigurer webMvcConfigurer() {
	         return new WebMvcConfigurer() {
	             @Override
	             public void configurePathMatch(PathMatchConfigurer configurer) {
	                 configurer.setUseTrailingSlashMatch(true);
	             }
	         };
	     }
	 


}
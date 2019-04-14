package com.gomeetdr;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

/**
 * This class is required to start the application. To start the application run
 * this class as Java application or Spring boot app.
 * 
 * @author parvajig
 */
@SpringBootApplication
public class RunApplication extends SpringBootServletInitializer {
	public static void main(String[] args) {
		SpringApplication.run(RunApplication.class, args);
	}
	
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(RunApplication.class);
    }
}
package com.intellisoft.amsfunsoft;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class AmsfunsoftApplication {

	public static void main(String[] args) {
		SpringApplication.run(AmsfunsoftApplication.class, args);
	}

}

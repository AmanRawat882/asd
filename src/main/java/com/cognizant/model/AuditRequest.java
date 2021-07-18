package com.cognizant.model;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Data
@Component
public class AuditRequest {
	
	private String projectName;
	private String projectManagerName;
	private String applicationOwnerName;
	private AuditDetails auditDetails;
}


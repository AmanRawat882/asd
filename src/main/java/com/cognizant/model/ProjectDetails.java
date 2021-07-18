package com.cognizant.model;

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

public class ProjectDetails {

	private String projectName;
	
	private String projectManagerName;
	
	private String applicationOwnerName;
}

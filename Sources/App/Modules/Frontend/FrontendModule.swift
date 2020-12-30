//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor
import Fluent

struct FrontendModule: Module {

	var router: RouteCollection? {
		FrontendRouter()
	}
	
}

//
//  File.swift
//  
//
//  Created by Jack Tudor on 31/12/2020.
//

import Fluent
import Vapor

struct AdminModule: Module {

	var router: RouteCollection? { AdminRouter() }
}

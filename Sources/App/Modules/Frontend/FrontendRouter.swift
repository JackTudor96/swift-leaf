//
//  File.swift
//  
//
//  Created by Jack Tudor on 14/12/2020.
//

import Vapor

struct FrontendRouter: RouteCollection {

	let controller = FrontendController()

	func boot(routes: RoutesBuilder) throws {
		routes.get(use: controller.homeView)
	}
}

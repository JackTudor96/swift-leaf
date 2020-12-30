//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor

struct UserRouter: RouteCollection {

	let controller = UserFrontendController()

	func boot(routes: RoutesBuilder) throws {
		routes.get("/sign-in", use: controller.login)
		routes.grouped(UserModelCredentialsAuthenticator()).post("/sign-in", use: controller.login)
		routes.grouped(UserModelSessionAuthenticator()).get("logout", use: controller.logout)
	}
	
}

//
//  File.swift
//  
//
//  Created by Jack Tudor on 14/12/2020.
//

import Vapor

struct FrontendController {

	func homeView(req: Request) throws -> EventLoopFuture<View> {
		var email: String?
		if let user = req.auth.get(UserModel.self) {
			email = user.email
		}
		return req.leaf.render(template: "Frontend/home", context: [
			"title": .string("myPage - Home"),
			"header": .string("Hi there, "),
			"message": .string("welcome to my awesome page!"),
			"isLoggedIn": .bool(email != nil),
			"email": .string(email),
		])
	}
	
}

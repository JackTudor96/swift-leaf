//
//  File.swift
//  
//
//  Created by Jack Tudor on 14/12/2020.
//

import Vapor

struct FrontendController {

	func homeView(req: Request) throws -> EventLoopFuture<View> {
		return req.leaf.render(template: "home", context: [
			"title": "myPage - Home",
			"header": "Hi there,",
			"message": "welcome to my awesome page!"
		])
	}
}

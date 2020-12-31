//
//  File.swift
//  
//
//  Created by Jack Tudor on 14/12/2020.
//

import Vapor

struct BlogRouter: RouteCollection {

	let controller = BlogFrontendController()

	func boot(routes: RoutesBuilder) throws {
		routes.get("blog", use: controller.blogView)
		routes.get(.anything, use: controller.postView)
		let blogAPI = routes.grouped("api", "blog")
		let categories = blogAPI.grouped("categories")
		BlogCategoryAPIController().setupListRoute(routes: categories)
	}

}

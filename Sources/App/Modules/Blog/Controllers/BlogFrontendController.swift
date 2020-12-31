//
//  File.swift
//  
//
//  Created by Jack Tudor on 14/12/2020.
//

import LoremSwiftum
import Fluent
import Leaf
import Foundation
import Vapor

struct BlogFrontendController {

	func blogView(req: Request) throws -> EventLoopFuture<View> {
		BlogPostModel.query(on: req.db)
			.sort(\.$date, .descending)
			.with(\.$category)
			.all()
			.mapEach(\.leafData)
			.flatMap {
				req.leaf.render(template: "Blog/Frontend/blog", context: [
					"title": .string("myPage - Blog"),
					"posts": .array($0),
				])
			}
	}

	func postView(req: Request) throws -> EventLoopFuture<Response> {
		let slug = req.url.path.trimmingCharacters(in: .init(charactersIn: "/"))

		return BlogPostModel.query(on: req.db)
			.filter(\.$slug == slug)
			.with(\.$category)
			.first()
			.flatMap { post in
				guard let post = post else {
					return req.eventLoop.future(req.redirect(to: "/"))
				}
				let context: LeafRenderer.Context = [
					"title": .string("myPage - \(post.title)"),
					"post": post.leafData,
				]
				return req.leaf.render(template: "Blog/Frontend/post", context: context)
					.encodeResponse(for: req)
			}
	}


}

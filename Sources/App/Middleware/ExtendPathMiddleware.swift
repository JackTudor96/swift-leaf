//
//  File.swift
//  
//
//  Created by Jack Tudor on 19/12/2020.
//

import Foundation
import Vapor

struct ExtendPathMiddleware: Middleware {

	func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
		if !request.url.path.hasSuffix("/") && !request.url.path.contains(".") {
			let response = request.redirect(to: request.url.path + "/", type: .permanent)
			return request.eventLoop.makeSucceededFuture(response)
		}
		return next.respond(to: request)
	}
}

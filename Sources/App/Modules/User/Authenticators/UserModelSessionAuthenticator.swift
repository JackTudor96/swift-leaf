//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor
import Fluent

struct UserModelSessionAuthenticator: SessionAuthenticator {

	typealias User = UserModel

	func authenticate(sessionID: UUID, for request: Request) -> EventLoopFuture<Void> {
		User.find(sessionID, on: request.db).map { user in
			if let user = user {
				request.auth.login(user)
			}
		}
	}

}

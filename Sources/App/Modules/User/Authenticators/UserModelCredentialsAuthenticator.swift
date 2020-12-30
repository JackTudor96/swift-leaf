//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor
import Fluent

struct UserModelCredentialsAuthenticator: CredentialsAuthenticator {
	
	typealias Credentials = Input

	struct Input: Content {
		let email: String
		let password: String
	}

	func authenticate(credentials: Credentials, for request: Request) -> EventLoopFuture<Void> {
		UserModel.query(on: request.db)
			.filter(\.$email == credentials.email)
			.first()
			.map {
				do {
					if let user = $0,
					   try Bcrypt.verify(credentials.password, created: user.password) {
						request.auth.login(user)
					}
				} catch {

				}
			}
	}
}

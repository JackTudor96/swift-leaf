//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor
import Fluent

struct UserMigrationSeed: Migration {

	func prepare(on database: Database) -> EventLoopFuture<Void> {
		[
			UserModel(email: "root@localhost.com",
					  password: try! Bcrypt.hash("NotSafe1"))
		].create(on: database)
	}

	func revert(on database: Database) -> EventLoopFuture<Void> {
		UserModel.query(on: database).delete()
	}
	
}

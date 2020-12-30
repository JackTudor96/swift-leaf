//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor
import Fluent

struct UserMigration_V1_0_0: Migration {

	func prepare(on database: Database) -> EventLoopFuture<Void> {
		database.schema(UserModel.schema)
			.id()
			.field(UserModel.FieldKeys.email, .string, .required)
			.field(UserModel.FieldKeys.password, .string, .required)
			.unique(on: UserModel.FieldKeys.email)
			.create()
	}

	func revert(on database: Database) -> EventLoopFuture<Void> {
		database.schema(UserModel.schema).delete()
	}
}

//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor
import Fluent

struct UserModule: Module {

	var router: RouteCollection? { UserRouter() }

	var migrations: [Migration] {
		[
			UserMigration_V1_0_0(),
			UserMigrationSeed(),
		]
	}
}

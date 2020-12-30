//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Vapor
import Fluent

struct BlogModule: Module {

	var router: RouteCollection? {
		BlogRouter()
	}

	var migrations: [Migration] {
		[
			BlogMigration_v1_0_0(),
			BlogMigrationSeed(),
		]
	}
}

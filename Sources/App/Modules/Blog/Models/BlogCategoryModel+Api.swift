//
//  File.swift
//  
//
//  Created by Jack Tudor on 31/12/2020.
//

import Vapor

extension BlogCategoryModel: ListContentRepresentable {

	struct ListItem: Content {
		let id: String
		let title: String

		init(model: BlogCategoryModel) {
			id = model.id!.uuidString
			title = model.title
		}
	}

	var listContent: ListItem { .init(model: self) }
	
}

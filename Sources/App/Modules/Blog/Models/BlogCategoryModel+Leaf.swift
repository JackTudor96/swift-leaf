//
//  File.swift
//  
//
//  Created by Jack Tudor on 30/12/2020.
//

import Leaf

extension BlogCategoryModel: LeafDataRepresentable {

	var leafData: LeafData {

		.dictionary([
			"id": .string(id?.uuidString),
			"title": .string(title),
		])

	}
}

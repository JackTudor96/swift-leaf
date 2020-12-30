//
//  File.swift
//  
//
//  Created by Jack Tudor on 14/12/2020.
//

import Foundation
import Leaf

struct BlogPost {
	let title: String
	let slug: String
	let image: String
	let excerpt: String
	let date: Date
	public let category: String?
	let content: String
}

extension BlogPost: LeafDataRepresentable {
	var leafData: LeafData {
		.dictionary([
			"title": .string(title),
			"slug": .string(slug),
			"image": .string(image),
			"excerpt": .string(excerpt),
			"date": .double(date.timeIntervalSinceReferenceDate),
			"category": .string(category),
			"content": .string(content),
		])
	}
}

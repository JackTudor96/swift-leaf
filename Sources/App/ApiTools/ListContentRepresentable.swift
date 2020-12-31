//
//  File.swift
//  
//
//  Created by Jack Tudor on 31/12/2020.
//

import Vapor

protocol ListContentRepresentable {

	associatedtype ListItem: Content

	var listContent: ListItem { get }
	
}

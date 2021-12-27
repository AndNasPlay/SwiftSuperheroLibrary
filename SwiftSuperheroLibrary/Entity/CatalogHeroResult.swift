//
//  CatalogHeroResult.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 21.08.2021.
//

import Foundation

// MARK: - CatalogHeroResult
struct CatalogHeroResult: Codable {
	let data: CharacterCatalog?
}

// MARK: - DataClass
struct CharacterCatalog: Codable {
	let count: Int?
	let results: [HeroResult]?
}

// MARK: - Result
struct HeroResult: Codable {
	let id: Int?
	let name: String?
	let description: String?
	var thumbnail: [String: String]
	let urls: [[String: String]]
}

//
//  SwiftSuperheroLibraryTests.swift
//  SwiftSuperheroLibraryTests
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import XCTest
@testable import SwiftSuperheroLibrary

class SwiftSuperheroLibraryTests: XCTestCase {

	var requestFactory: RequestFactory?

	override func setUpWithError() throws {
		requestFactory = RequestFactory(baseUrl: UserSettings.baseUrl)
	}

	override func tearDownWithError() throws {
		requestFactory = nil
	}

	func testGetCatalogHeroes() throws {
		let getCatalogHeroes = try XCTUnwrap(requestFactory).makeHeroesRequestFatory()
		let signedIn = expectation(description: "get catalog")
		getCatalogHeroes.heroCatalog(limit: 1) { response in
			switch response.result {
			case .success(let hero):
				XCTAssertEqual(hero.data?.count, 1)
				signedIn.fulfill()
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}
		}
		waitForExpectations(timeout: 20)
	}

	func testGetHeroByName() throws {
		let getHeroByName = try XCTUnwrap(requestFactory).makeSearchByNameRequestFatory()
		let signedIn = expectation(description: "get hero")
		getHeroByName.searchHeroByName(name: "hulk") { response in
			switch response.result {
			case .success(let hero):
				XCTAssertEqual(hero.data?.results?.first?.name, "Hulk")
				signedIn.fulfill()
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}
		}
		waitForExpectations(timeout: 20)
	}
}

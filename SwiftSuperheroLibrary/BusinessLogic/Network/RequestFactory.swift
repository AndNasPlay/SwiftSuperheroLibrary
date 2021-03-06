//
//  RequestFactory.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 20.08.2021.
//

import Foundation
import Alamofire

class RequestFactory {

	let baseUrl: URL
	init(baseUrl: URL) {
		self.baseUrl = baseUrl
	}

	func makeErrorParser() -> AbstractErrorParser {
		return ErrorParser()
	}

	lazy var commonSession: Session = {
		let configuration = URLSessionConfiguration.default
		configuration.httpShouldSetCookies = false
		configuration.headers = .default
		let manager = Session(configuration: configuration)
		return manager
	}()

	let sessionQueue = DispatchQueue.global(qos: .utility)
	let sessionCallBackQueue = DispatchQueue.main

	func makeHeroesRequestFactory() -> CatalogHeroReqestFactory {
		let errorParser = makeErrorParser()
		return HeroCatalog(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}

	func makeSearchByNameRequestFactory() -> SearchByNameReqestFactory {
		let errorParser = makeErrorParser()
		return SearchByName(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}
}

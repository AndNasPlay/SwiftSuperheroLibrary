//
//  SearchByName.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import Foundation
import Alamofire
import CryptoKit

class SearchByName: AbstractRequestFactory, SearchByNameReqestFactory {

	let errorParser: AbstractErrorParser
	let sessionManager: Session
	let queue: DispatchQueue
	let baseUrl: URL
	init(
		errorParser: AbstractErrorParser,
		sessionManager: Session,
		queue: DispatchQueue = DispatchQueue.main,
		baseUrl: URL
	) {
		self.errorParser = errorParser
		self.sessionManager = sessionManager
		self.queue = queue
		self.baseUrl = baseUrl
	}

	func searchHeroByName(name: String, completionHandler: @escaping (AFDataResponse<CatalogHeroResult>) -> Void) {
		let requestModel = SearchHeroByNameRequest(
			baseUrl: baseUrl,
			name: name
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct SearchHeroByNameRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "characters"
		let name: String
		var parameters: Parameters? {
			return [
				"ts" : UserSettings.ts,
				"apikey" : UserSettings.publicKey,
				"hash" : UserSettings.hash,
				"name" : name
			]

		}
	}
}

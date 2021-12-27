//
//  HeroCatalog.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 23.08.2021.
//

import Foundation
import Alamofire

class HeroCatalog: AbstractRequestFactory, CatalogHeroReqestFactory {

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

	func heroCatalog(limit: Int, completionHandler: @escaping (AFDataResponse<CatalogHeroResult>) -> Void) {
		let requestModel = HeroCatalogRequest(
			baseUrl: baseUrl,
			limit: limit
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct HeroCatalogRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "characters"
		let limit: Int
		var parameters: Parameters? {
			return [
				"ts": UserSettings.tsForApi,
				"apikey": UserSettings.publicKey,
				"hash": UserSettings.hash,
				"limit": "\(limit)"
			]
		}
	}
}

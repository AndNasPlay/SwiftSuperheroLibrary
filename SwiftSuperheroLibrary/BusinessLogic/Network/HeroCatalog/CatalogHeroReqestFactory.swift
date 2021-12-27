//
//  CatalogHeroReqestFactory.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 21.08.2021.
//

import Foundation
import Alamofire

protocol CatalogHeroReqestFactory {
	func heroCatalog(limit: Int, completionHandler: @escaping (AFDataResponse<CatalogHeroResult>) -> Void)
}

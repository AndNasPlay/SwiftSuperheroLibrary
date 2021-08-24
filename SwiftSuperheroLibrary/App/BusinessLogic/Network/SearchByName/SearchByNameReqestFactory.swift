//
//  SearchByNameReqestFactory.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import Foundation
import Alamofire

protocol SearchByNameReqestFactory {
	func searchHeroByName(name: String, completionHandler: @escaping (AFDataResponse<CatalogHeroResult>) -> Void)
}

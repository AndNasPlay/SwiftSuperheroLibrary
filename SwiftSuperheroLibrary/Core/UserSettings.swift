//
//  UserSettings.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 23.08.2021.
//

import Foundation
import CryptoKit

final class  UserSettings {

	static var baseUrl: URL = URL(string: "https://gateway.marvel.com:443/v1/public/")!

	static var privateKey: String = "921e2cc332a62cfcb5baad8c3b2aac2d34e54a37"

	static var publicKey: String = "b21b858c46473350e79113f084918485"

	static var tsForApi: String = String(Date().timeIntervalSince1970)

	static var hash: String {
		let hash = Insecure.MD5.hash(
			data: "\(UserSettings.tsForApi)\(UserSettings.privateKey)\(UserSettings.publicKey)".data(using: .utf8) ?? Data())
				return hash.map {
					String(format: "%02hhx", $0)
				}
				.joined()
	}
}

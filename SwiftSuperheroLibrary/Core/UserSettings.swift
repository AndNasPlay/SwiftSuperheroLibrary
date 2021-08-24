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

	static var privateKey: String = "__"

	static var publicKey: String = "__"

	static var ts: String = String(Date().timeIntervalSince1970)

	static var hash: String {
		let hash = Insecure.MD5.hash(data: "\(UserSettings.ts)\(UserSettings.privateKey)\(UserSettings.publicKey)".data(using: .utf8) ?? Data())
				return hash.map{
					String(format: "%02hhx", $0)
				}
				.joined()
	}
}

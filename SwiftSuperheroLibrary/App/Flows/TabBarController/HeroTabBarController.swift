//
//  HeroTabBarController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import UIKit

class HeroTabBarController: UITabBarController {

	let factory = RequestFactory(baseUrl: UserSettings.baseUrl)

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .systemBackground
		UITabBar.appearance().barTintColor = .systemBackground
		tabBar.tintColor = .label
		setupVCs()

	}

	func setupVCs() {
		viewControllers = [
			createNavController(for: HeroCatalogTableViewController(requestFactory: factory),
								title: NSLocalizedString("Hero Catalog", comment: ""),
								image: UIImage(systemName: "house")!),
			createNavController(for: HeroSearchViewController(requestFactory: factory),
								title: NSLocalizedString("Search Hero", comment: ""),
								image: UIImage(systemName: "magnifyingglass")!)
		]
	}

	fileprivate func createNavController(for rootViewController: UIViewController,
										 title: String,
										 image: UIImage) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		navController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title
		return navController
	}
}

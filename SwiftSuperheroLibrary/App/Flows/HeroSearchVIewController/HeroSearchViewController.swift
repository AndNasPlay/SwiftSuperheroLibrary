//
//  HeroSearchViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import UIKit
import Alamofire

class HeroSearchViewController: UIViewController, HeroSearchViewDelegate {

	let requestFactory: RequestFactory
	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var heroArr = [HeroResult]()

	private func loadData() {
		self.heroArr.removeAll()
		self.requestFactory.makeSearchByNameRequestFatory().searchHeroByName(name: heroSearchView.searchTextField.text ?? "hulk" ) { response in
			DispatchQueue.main.async { [self] in
				switch response.result {
				case .success(let catalog):
					self.heroArr.append(contentsOf: (catalog.data?.results)!)
					print(self.heroArr)
					let detailViewController = HeroSearchCatalogTableViewController(heroArr: heroArr)
					self.navigationController?.pushViewController(detailViewController, animated: true)
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	func search() {
		loadData()
	}

	var heroSearchView = HeroSearchView()

	override func loadView() {
		heroSearchView.delegate = self
		view = heroSearchView
	}

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

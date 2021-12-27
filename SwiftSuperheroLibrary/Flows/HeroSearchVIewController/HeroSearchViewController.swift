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

	var heroSearchView = HeroSearchView()

	private func loadData() {
		self.heroArr.removeAll()
		self.requestFactory.makeSearchByNameRequestFactory().searchHeroByName(
			name: heroSearchView.searchTextField.text ?? "hulk" ) { response in
			DispatchQueue.main.async { [self] in
				switch response.result {
				case .success(let catalog):
					if (catalog.data?.results?.count ?? 0) > 0 {
						self.heroArr.append(contentsOf: (catalog.data?.results)!)
						let detailViewController = HeroSearchCatalogTableViewController(heroArr: heroArr)
						self.navigationController?.pushViewController(detailViewController, animated: true)
					}
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	func search() {
		loadData()
	}

	override func loadView() {
		heroSearchView.delegate = self
		view = heroSearchView
		self.heroSearchView.applyGradient(colours: [.black, .red])
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.navigationBar.isHidden = true
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		self.navigationController?.navigationBar.isHidden = true
	}

}

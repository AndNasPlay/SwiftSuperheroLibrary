//
//  FirstTableViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 18.08.2021.
//

import UIKit
import Alamofire

class FirstTableViewController: UITableViewController, UISearchResultsUpdating {

	let requestFactory: RequestFactory
	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var productArr = [Result]()

	var testArray = ["Гамора", "Соколиный глаз", "Халк", "Каратель", "Алая ведьма", "Шторм"]

	var searchController: UISearchController!
	var newController = ResultFirstViewController()

	private func loadData() {
		self.requestFactory.makeHeroesRequestFatory().heroCatalog(limit: 4) { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let catalog):
					self.productArr.append(contentsOf: (catalog.data?.results)!)
					self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.backgroundColor = .white
		searchController = UISearchController(searchResultsController: newController)
		searchController.searchResultsUpdater = self
		searchController.searchBar.sizeToFit()

		loadData()

		tableView.tableHeaderView = searchController.searchBar

		definesPresentationContext = true
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return productArr.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "identy")
		cell.textLabel?.text = productArr[indexPath.row].name
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailViewController = HeroViewController()
		detailViewController.heroView.heroNameLable.text = productArr[indexPath.row].name
		navigationController?.pushViewController(detailViewController, animated: true)
	}

	func updateSearchResults(for searchController: UISearchController) {

		if !searchController.isActive {
			return
		}
//		newController.resultArray = productArr.filter { hero in
//			return
//				hero.lowercased().contains(searchController.searchBar.text!.lowercased())
//		}
		newController.updateTableView()

	}
}


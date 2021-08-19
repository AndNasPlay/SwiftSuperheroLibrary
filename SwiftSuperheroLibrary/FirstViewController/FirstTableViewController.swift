//
//  FirstTableViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 18.08.2021.
//

import UIKit

class FirstTableViewController: UITableViewController, UISearchResultsUpdating {

	var testArray = ["Гамора", "Соколиный глаз", "Халк", "Каратель", "Алая ведьма", "Шторм"]

	var searchController: UISearchController!
	var newController = ResultFirstViewController()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.backgroundColor = .white

		searchController = UISearchController(searchResultsController: newController)
		searchController.searchResultsUpdater = self
		searchController.searchBar.sizeToFit()

		tableView.tableHeaderView = searchController.searchBar

		definesPresentationContext = true
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return testArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "identy")
		cell.textLabel?.text = testArray[indexPath.row]
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailViewController = HeroViewController()
		detailViewController.heroView.heroNameLable.text = testArray[indexPath.row]
		navigationController?.pushViewController(detailViewController, animated: true)
	}

	func updateSearchResults(for searchController: UISearchController) {

		if !searchController.isActive {
			return
		}
		newController.resultArray = testArray.filter { hero in
			return
				hero.lowercased().contains(searchController.searchBar.text!.lowercased())
		}
		newController.updateTableView()

	}
}


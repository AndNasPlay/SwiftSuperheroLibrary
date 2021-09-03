//
//  HeroCatalogTableViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 18.08.2021.
//

import UIKit
import Alamofire
import SDWebImage

class HeroCatalogTableViewController: UITableViewController {

	let requestFactory: RequestFactory
	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var heroArr = [HeroResult]()
	private var tableCellHeight: CGFloat = 120.0
	private let searchController = UISearchController(searchResultsController: nil)
	private let defaultImagePath: String = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
	private let defaultImageExtension: String = ".jpg"

	private var searchBarIsEmpty: Bool {
		guard let text = searchController.searchBar.text else { return false }
		return text.isEmpty
	}

	private var isFiltering: Bool {
		return searchController.isActive && !searchBarIsEmpty
	}

	private var filteredHeroArr: [HeroResult] {
		guard !searchText.isEmpty else { return heroArr }
		return heroArr.filter { hero in
			return
				(hero.name?.lowercased().contains(searchController.searchBar.text!.lowercased())) ?? false
		}
	}

	private var searchText: String {
		searchController.searchBar.text ?? ""
	}

	private func loadData() {
		self.requestFactory.makeHeroesRequestFactory().heroCatalog(limit: 100) { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let catalog):
					if (catalog.data?.results != nil) {
						self.heroArr.append(contentsOf: (catalog.data?.results)!)
						self.tableView.reloadData()
					}
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white

		searchController.searchResultsUpdater = self
		searchController.searchBar.sizeToFit()
		searchController.searchBar.placeholder = "Search"
		searchController.obscuresBackgroundDuringPresentation = false

		navigationItem.searchController = searchController
		definesPresentationContext = true

		self.tableView.register(HeroCatalogTableViewCell.self, forCellReuseIdentifier: HeroCatalogTableViewCell.identifier)

		if heroArr.isEmpty {
			loadData()
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredHeroArr.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let urlPhoto: String = "\(filteredHeroArr[indexPath.row].thumbnail["path"] ?? defaultImagePath).\( filteredHeroArr[indexPath.row].thumbnail["extension"] ?? defaultImageExtension)"
		let cell = self.tableView.dequeueReusableCell(withIdentifier: HeroCatalogTableViewCell.identifier,
													  for: indexPath) as! HeroCatalogTableViewCell

		cell.heroNameLabel.text = filteredHeroArr[indexPath.row].name
		cell.heroImageView.sd_setImage(with: URL(string: urlPhoto), placeholderImage: UIImage(named: "heroTestImg"))

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let urlPhoto: String = "\(filteredHeroArr[indexPath.row].thumbnail["path"] ?? defaultImagePath).\( filteredHeroArr[indexPath.row].thumbnail["extension"] ?? defaultImageExtension)"
		let detailViewController = HeroViewController()
		detailViewController.heroView.heroNameLable.text = filteredHeroArr[indexPath.row].name
		detailViewController.heroView.heroPhoto.sd_setImage(with: URL(string: urlPhoto),
															placeholderImage: UIImage(named: "heroTestImg"))
		detailViewController.heroView.aboutHeroLable.text = filteredHeroArr[indexPath.row].description
		navigationController?.pushViewController(detailViewController, animated: true)
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableCellHeight
	}
}

extension HeroCatalogTableViewController: UISearchResultsUpdating {

	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text!)
	}

	private func filterContentForSearchText(_ searchText: String) {
		var filteredHeroArr: [HeroResult]? {
			if isFiltering {
				return heroArr.filter { hero in
					return
						(hero.name?.lowercased().contains(searchController.searchBar.text!.lowercased())) ?? false
				}
			} else {
				return heroArr
			}
		}
		tableView.reloadData()
	}
}

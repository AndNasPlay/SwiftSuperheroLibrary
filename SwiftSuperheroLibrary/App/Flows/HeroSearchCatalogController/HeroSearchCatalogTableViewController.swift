//
//  HeroSearchCatalogTableViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import UIKit
import SDWebImage

class HeroSearchCatalogTableViewController: UITableViewController {

	let heroArr: [HeroResult]
	init(heroArr: [HeroResult]) {
		self.heroArr = heroArr
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var tableCellHeight: CGFloat = 120.0
	private let defaultImagePath: String = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
	private let defaultImageExtension: String = ".jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white

		self.tableView.register(HeroCatalogTableViewCell.self, forCellReuseIdentifier: HeroCatalogTableViewCell.identifier)
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return heroArr.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let urlPhoto: String = "\(heroArr[indexPath.row].thumbnail["path"] ?? defaultImagePath).\( heroArr[indexPath.row].thumbnail["extension"] ?? defaultImageExtension)"
		let cell = self.tableView.dequeueReusableCell(withIdentifier: HeroCatalogTableViewCell.identifier,
													  for: indexPath) as! HeroCatalogTableViewCell
		cell.heroNameLabel.text = heroArr[indexPath.row].name

		cell.heroImageView.sd_setImage(with: URL(string: urlPhoto), placeholderImage: UIImage(named: "heroTestImg"))

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableCellHeight
	}

}

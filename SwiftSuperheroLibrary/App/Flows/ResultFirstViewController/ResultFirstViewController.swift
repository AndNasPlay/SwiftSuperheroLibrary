//
//  ResultFirstViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 19.08.2021.
//

import UIKit

class ResultFirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	var resultArray = [String]()

	func updateTableView() {
		self.tableView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "HeroSearch"
		self.view.addSubview(self.tableView)
		self.tableView.backgroundColor = .white
		self.tableView.dataSource = self
		self.tableView.delegate = self
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		NSLayoutConstraint.activate([
			self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
			self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
			self.tableView.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
			self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		])
	}

	private lazy var tableView: UITableView = {
		let tableV = UITableView(frame: .zero, style: .insetGrouped)
		tableV.backgroundColor = .clear
		tableV.layer.borderColor = UIColor(named: "BasketVCTableViewBorderColor")?.cgColor
		tableV.translatesAutoresizingMaskIntoConstraints = false
		tableV.dataSource = self
		tableV.delegate = self
		tableV.rowHeight = UITableView.automaticDimension
		tableV.estimatedRowHeight = 140
		return tableV
	}()

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return resultArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "identy")
		cell.textLabel?.text = resultArray[indexPath.row]
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailViewController = HeroViewController()
		detailViewController.heroView.heroNameLable.text = resultArray[indexPath.row]
		navigationController?.pushViewController(detailViewController, animated: true)
	}
}

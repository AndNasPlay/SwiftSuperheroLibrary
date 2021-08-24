//
//  HeroSearchView.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import UIKit

protocol HeroSearchViewDelegate: AnyObject {
	func search()
}

class HeroSearchView: UIView {

	weak var delegate: HeroSearchViewDelegate?
	override init(frame: CGRect) {
		super.init(frame: frame)
		createSubviews()
		constraintsInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		createSubviews()
		constraintsInit()
	}

	private(set) lazy var instructionLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.textAlignment = .left
		text.numberOfLines = 0
		text.font = UIFont(name: "Helvetica-Bold", size: 20.0)
		text.text = "Введите имя искомого персонажа"
		return text
	}()

	private(set) lazy var searchButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = 2.0
		button.layer.masksToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Search", for: .normal)
		button.backgroundColor = .lightGray
		return button
	}()

	private(set) lazy var searchTextField: UITextField = {
		var searchTF = UITextField()
		searchTF.backgroundColor = .lightText
		searchTF.placeholder = "Hero name"
		searchTF.borderStyle = .roundedRect
		searchTF.isAccessibilityElement = true
		searchTF.translatesAutoresizingMaskIntoConstraints = false
		return searchTF
	}()

	func createSubviews() {
		backgroundColor = .white
		self.addSubview(instructionLable)
		self.addSubview(searchButton)
		self.addSubview(searchTextField)
		searchButton.addTarget(self,
							   action: #selector(handleSearchTouchUpInseide),
							   for: .touchUpInside)
	}
	
	func constraintsInit() {
		NSLayoutConstraint.activate([
			instructionLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			instructionLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
			instructionLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			instructionLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
			instructionLable.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),

			searchTextField.topAnchor.constraint(equalTo: self.instructionLable.bottomAnchor, constant: 50),
			searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

			searchButton.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 20),
			searchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
			searchButton.heightAnchor.constraint(equalToConstant: 50),
			searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
		])
	}

	@objc func handleSearchTouchUpInseide() {
		delegate?.search()
	}
}

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

	private let instructionLableTopAnchor: CGFloat = 50.0
	private let leadingTrailingAnchor: CGFloat = 20.0
	private let searchButtonleadingTrailingAnchor: CGFloat = 50.0
	private let searchButtonHeightAnchor: CGFloat = 50.0
	private let searchButtonSearchTextFieldTopAnchor: CGFloat = 50.0

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

	private(set) lazy var logoImg: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "logoImg")

		return image
	}()

	private(set) lazy var instructionLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.textAlignment = .center
		text.numberOfLines = 0
		text.font = UIFont(name: "Helvetica-Bold", size: 20.0)
		text.text = "What MARVEL character would you like to learn mone about?"
		return text
	}()

	private(set) lazy var searchButton: UIButton = {
		let button = UIButton()
		button.layer.masksToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Search", for: .normal)
		button.setBackgroundImage(UIImage(named: "sendBtn"), for: .normal)
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
		self.addSubview(instructionLable)
		self.addSubview(searchButton)
		self.addSubview(searchTextField)
		self.addSubview(logoImg)
		searchButton.addTarget(self,
							   action: #selector(handleSearchTouchUpInseide),
							   for: .touchUpInside)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			logoImg.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: leadingTrailingAnchor),
			logoImg.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: leadingTrailingAnchor),
			logoImg.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -leadingTrailingAnchor),
			logoImg.heightAnchor.constraint(equalToConstant: 200.0),

			instructionLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			instructionLable.topAnchor.constraint(equalTo: self.logoImg.bottomAnchor, constant: instructionLableTopAnchor),
			instructionLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingTrailingAnchor),
			instructionLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -leadingTrailingAnchor),

			searchTextField.topAnchor.constraint(equalTo: self.instructionLable.bottomAnchor, constant: searchButtonSearchTextFieldTopAnchor),
			searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingTrailingAnchor),
			searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -leadingTrailingAnchor),

			searchButton.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: searchButtonSearchTextFieldTopAnchor),
			searchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: searchButtonleadingTrailingAnchor),
			searchButton.heightAnchor.constraint(equalToConstant: searchButtonHeightAnchor),
			searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -searchButtonleadingTrailingAnchor)
		])
	}

	@objc func handleSearchTouchUpInseide() {
		delegate?.search()
	}
}

extension UIView {
	func applyGradient(colours: [UIColor]) -> Void {
		let gradient: CAGradientLayer = CAGradientLayer()
		gradient.frame = self.bounds
		gradient.colors = colours.map { $0.cgColor }
		gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
		gradient.endPoint = CGPoint(x :1.0, y: 0.5)
		self.layer.insertSublayer(gradient, at: 0)
	}
}

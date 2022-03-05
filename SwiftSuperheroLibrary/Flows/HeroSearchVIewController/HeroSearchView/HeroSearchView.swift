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

	private let instructionLableTopAnchor: CGFloat = 30.0
	private let leadingTrailingAnchor: CGFloat = 20.0
	private let searchButtonleadingTrailingAnchor: CGFloat = 50.0
	private let searchButtonHeightAnchor: CGFloat = 50.0
	private let searchButtonSearchTextFieldTopAnchor: CGFloat = 30.0
	private let logoHeightAnchor: CGFloat = 200.0
	private let gradientLayer = CAGradientLayer()

	weak var delegate: HeroSearchViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupGradient()
		self.translatesAutoresizingMaskIntoConstraints = false
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
		text.font = UIFont(name: "Helvetica-Bold", size: 16.0)
		text.adjustsFontSizeToFitWidth = true
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
	

	private func createSubviews() {
		self.addSubview(instructionLable)
		self.addSubview(searchButton)
		self.addSubview(searchTextField)
		self.addSubview(logoImg)
		searchButton.addTarget(self,
							   action: #selector(handleSearchTouchUpInseide),
							   for: .touchUpInside)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}

	private func setupGradient() {
		self.layer.addSublayer(gradientLayer)
		gradientLayer.colors = [UIColor.mainViewFirstColor.cgColor, UIColor.mainViewSecondColor.cgColor]
	}

	private func constraintsInit() {
		NSLayoutConstraint.activate([

			logoImg.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
										 constant: leadingTrailingAnchor),
			logoImg.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
										  constant: leadingTrailingAnchor),
			logoImg.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
										   constant: -leadingTrailingAnchor),
			logoImg.heightAnchor.constraint(equalToConstant: logoHeightAnchor),

			instructionLable.topAnchor.constraint(equalTo: logoImg.bottomAnchor,
													 constant: instructionLableTopAnchor),
			instructionLable.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													  constant: leadingTrailingAnchor),
			instructionLable.trailingAnchor.constraint(equalTo: self.trailingAnchor,
													   constant: -leadingTrailingAnchor),

			searchTextField.topAnchor.constraint(equalTo: instructionLable.bottomAnchor,
												 constant: searchButtonSearchTextFieldTopAnchor),
			searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													 constant: leadingTrailingAnchor),
			searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
													  constant: -leadingTrailingAnchor),

			searchButton.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor,
											  constant: searchButtonSearchTextFieldTopAnchor),
			searchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												  constant: searchButtonleadingTrailingAnchor),
			searchButton.heightAnchor.constraint(equalToConstant: searchButtonHeightAnchor),
			searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -searchButtonleadingTrailingAnchor)
		])
	}

	@objc func handleSearchTouchUpInseide() {
		delegate?.search()
	}
}

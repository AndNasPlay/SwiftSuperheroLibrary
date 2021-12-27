//
//  HeroView.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 19.08.2021.
//

import UIKit

protocol HeroViewDelegate: AnyObject {
	func showMore()
	func showDetailInformation()
}

class HeroView: UIView {

	weak var delegate: HeroViewDelegate?
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

	private(set) lazy var heroPhoto: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 8
		imageView.clipsToBounds = true
		imageView.layer.borderColor = UIColor.lightGray.cgColor
		imageView.layer.borderWidth = 2
		return imageView
	}()

	private(set) lazy var heroNameLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.numberOfLines = 0
		text.textAlignment = .center
		text.font = UIFont(name: "Helvetica-Bold", size: 28.0)
		return text
	}()

	private(set) lazy var aboutHeroLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.numberOfLines = 0
		text.font = UIFont(name: "Helvetica-Light", size: 15)
		return text
	}()

	func createSubviews() {
		backgroundColor = .white
		self.addSubview(heroPhoto)
		self.addSubview(heroNameLable)
		self.addSubview(aboutHeroLable)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([
			heroPhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			heroPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
			heroPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			heroPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
			heroPhoto.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),

			heroNameLable.topAnchor.constraint(equalTo: self.heroPhoto.bottomAnchor, constant: 50),
			heroNameLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			heroNameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

			aboutHeroLable.topAnchor.constraint(equalTo: self.heroNameLable.bottomAnchor, constant: 20),
			aboutHeroLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			aboutHeroLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
		])
	}

}

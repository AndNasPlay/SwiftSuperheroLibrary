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
		let image = UIImageView()
		image.image = UIImage(named: "heroTestImg")
		image.translatesAutoresizingMaskIntoConstraints = false
		image.layer.masksToBounds = true
		return image
	}()

	private(set) lazy var heroNameLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.text = "Iron-man"
		text.font = UIFont(name: "Helvetica-Bold", size: 28.0)
		return text
	}()

	private(set) lazy var aboutHeroLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.font = UIFont(name: "Helvetica-Light", size: 15)
		text.text = "about Herot Lable"
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
			heroPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
			heroPhoto.widthAnchor.constraint(equalToConstant: 150),
			heroPhoto.heightAnchor.constraint(equalToConstant: 225),

			heroNameLable.topAnchor.constraint(equalTo: self.heroPhoto.bottomAnchor, constant: 80),
			heroNameLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
			heroNameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 100),

			aboutHeroLable.topAnchor.constraint(equalTo: self.heroNameLable.bottomAnchor, constant: 20),
			aboutHeroLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
			aboutHeroLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 100),
		])
	}

}

//
//  HeroCatalogTableViewCell.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import UIKit

class HeroCatalogTableViewCell: UITableViewCell {

	static let identifier = "HeroTableViewCell"

	let heroNameLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = .systemFont(ofSize: 16, weight: .regular)
		lable.text = "name"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var heroImageViewView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 10.0
		view.layer.shadowColor = UIColor.darkGray.cgColor
		view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
		view.layer.shadowRadius = 10.0
		view.layer.shadowOpacity = 0.9
		return view
	}()

	let heroImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10.0
		return imageView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		contentView.addSubview(heroNameLabel)
		contentView.addSubview(heroImageViewView)
		heroImageViewView.addSubview(heroImageView)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([

			heroImageViewView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
												   constant: 10),
			heroImageViewView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
											   constant: 10),
			heroImageViewView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,
												 multiplier: 0.3),
			heroImageViewView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
												  constant: -10),

			heroImageView.topAnchor.constraint(equalTo: self.heroImageViewView.topAnchor),
			heroImageView.leftAnchor.constraint(equalTo: self.heroImageViewView.leftAnchor),
			heroImageView.rightAnchor.constraint(equalTo: self.heroImageViewView.rightAnchor),
			heroImageView.bottomAnchor.constraint(equalTo: self.heroImageViewView.bottomAnchor),

			heroNameLabel.leadingAnchor.constraint(equalTo: self.heroImageView.trailingAnchor,
												   constant: 10),
			heroNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			heroNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,
												 multiplier: 0.6),
			heroNameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor,
												  multiplier: 0.7)
		])
	}
}

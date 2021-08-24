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

	let heroImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 8
		imageView.clipsToBounds = true
		imageView.layer.borderColor = UIColor.lightGray.cgColor
		imageView.layer.borderWidth = 2
		return imageView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		contentView.addSubview(heroNameLabel)
		contentView.addSubview(heroImageView)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			heroImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
			heroImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
			heroImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3),
			heroImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),

			heroNameLabel.leadingAnchor.constraint(equalTo: self.heroImageView.trailingAnchor, constant: 10),
			heroNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			heroNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6),
			heroNameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.7)
		])
	}
}

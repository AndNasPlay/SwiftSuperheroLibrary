//
//  HeroViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 19.08.2021.
//

import UIKit

class HeroViewController: UIViewController, HeroViewDelegate  {

	func showMore() {

	}

	func showDetailInformation() {

	}

	var heroView = HeroView()

	override func loadView() {
		heroView.delegate = self
		view = heroView
	}

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//
//  HeroSearchViewController.swift
//  SwiftSuperheroLibrary
//
//  Created by Андрей Щекатунов on 24.08.2021.
//

import UIKit
import Alamofire

class HeroSearchViewController: UIViewController, HeroSearchViewDelegate, UIScrollViewDelegate {

	let requestFactory: RequestFactory

	private var keyboardDismissTapGesture: UIGestureRecognizer?

	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private var heroArr = [HeroResult]()

	private(set) lazy var mainScrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.showsVerticalScrollIndicator = true
		return scroll
	}()

	var heroSearchView = HeroSearchView()

	private func loadData() {
		self.heroArr.removeAll()
		self.requestFactory.makeSearchByNameRequestFactory().searchHeroByName(
			name: heroSearchView.searchTextField.text ?? "hulk" ) { response in
			DispatchQueue.main.async { [self] in
				switch response.result {
				case .success(let catalog):
					if (catalog.data?.results?.count ?? 0) > 0 {
						self.heroArr.append(contentsOf: (catalog.data?.results)!)
						let detailViewController = HeroSearchCatalogTableViewController(heroArr: heroArr)
						self.navigationController?.pushViewController(detailViewController, animated: true)
					}
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	func search() {
		loadData()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.navigationBar.isHidden = true
		self.view.backgroundColor = UIColor.mainViewFirstColor
		self.view.addSubview(mainScrollView)
		self.mainScrollView.addSubview(heroSearchView)
		mainScrollView.delegate = self
		heroSearchView.delegate = self
		constraintsInit()
		addObserverForKeyboard()
    }

	@objc func keyboardWillShow(notification: NSNotification) {

		if keyboardDismissTapGesture == nil {
			keyboardDismissTapGesture = UITapGestureRecognizer(target: self,
															   action: #selector(dismissKeyboard))
			keyboardDismissTapGesture?.cancelsTouchesInView = false
			self.view.addGestureRecognizer(keyboardDismissTapGesture!)
		}

		guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		else { return }

		let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height - 100.0, right: 0.0)
		mainScrollView.contentInset = contentInsets
		mainScrollView.scrollIndicatorInsets = contentInsets
	}

	@objc func keyboardWillHide(notification: NSNotification) {

		if keyboardDismissTapGesture != nil {
			self.view.removeGestureRecognizer(keyboardDismissTapGesture!)
			keyboardDismissTapGesture = nil
		}

		let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

		mainScrollView.contentInset = contentInsets
		mainScrollView.scrollIndicatorInsets = contentInsets
	}

	@objc func dismissKeyboard(sender: UITapGestureRecognizer) {
		view.endEditing(true)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		self.navigationController?.navigationBar.isHidden = true
		addObserverForKeyboard()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		removeObserverForKeyboard()
	}

	private func addObserverForKeyboard() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)

		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}

	private func removeObserverForKeyboard() {
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillShowNotification,
												  object: nil)

		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillHideNotification,
												  object: nil)
	}

	private func constraintsInit() {

		let contentViewCenterY = heroSearchView.centerYAnchor.constraint(equalTo: mainScrollView.centerYAnchor)
		contentViewCenterY.priority = .defaultLow

		NSLayoutConstraint.activate([

			heroSearchView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
			contentViewCenterY,

			mainScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			mainScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
			mainScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			mainScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),

			heroSearchView.leadingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leadingAnchor),
			heroSearchView.trailingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.trailingAnchor),
			heroSearchView.bottomAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.bottomAnchor),
			heroSearchView.topAnchor.constraint(equalTo: mainScrollView.topAnchor)
			])
	}
}

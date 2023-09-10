//
//  ViewController.swift
//  ListAccessibility
//
//  Created by Felipe Hilst on 04/08/23.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view = tableView
		self.title = "TITLE"
		guard let nC = self.navigationController else { return }
		nC.setNavigationBarHidden(false, animated: false)

		let new = UIAccessibilityCustomRotor(systemType: .heading) { (predicate) in
			if predicate.searchDirection == .next {
				print("Swipe Down \(predicate)")
			}
			return nil
		}
		self.accessibilityCustomRotors = [new]
	}

	private(set) lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.translatesAutoresizingMaskIntoConstraints = false

		table.delegate = self
		table.dataSource = self

		table.estimatedRowHeight = 200
		table.separatorStyle = .none
		table.contentInset = .init(top: 20, left: .zero, bottom: .zero, right: .zero)

		table.register(CardCell.self, forCellReuseIdentifier: CardCell.description())
		return table
	}()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 10 }
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: CardCell? = tableView.dequeueReusableCell(withIdentifier: CardCell.description(), for: indexPath) as? CardCell
		cell?.index = indexPath.row
		return cell ?? UITableViewCell()
	}
}



extension ViewController {
	func handleSwipeDown() {
		print("Swiped Down!")
	}
}


//
//  CardCell.swift
//  ListAccessibility
//
//  Created by Felipe Hilst on 04/08/23.
//

import UIKit

final class CardCell: UITableViewCell {
	private lazy var containerStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			bigLabel,
			smallLabel,
			button,
		])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.layoutMargins = .init(top: 16, left: 24, bottom: 24, right: -20)
		stack.isLayoutMarginsRelativeArrangement = true
		stack.distribution = .fill
		stack.axis = .vertical
		stack.spacing = 12
		stack.alignment = .leading
		stack.backgroundColor = .white
		return stack
	}()

	private lazy var bigLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = .boldSystemFont(ofSize: 24)
		return label
	}()

	private lazy var smallLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = .italicSystemFont(ofSize: 16)
		return label
	}()

	private lazy var button: UIButton = {
		let button = UIButton(type: .roundedRect)
		button.isEnabled = true
		button.setTitle("Button", for: .normal)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		return button
	}()

	@objc
	private func buttonAction() {
		print(":=> \(bigLabel.text ?? "") \(smallLabel.text ?? "")")
	}

	var index: Int? {
		didSet { setupData() }
	}

	private func setupData() {
		guard let data = index else { return }
		bigLabel.text = "BIG LABEL \(data)"
		smallLabel.text = "SMALL LABEL \(data)"
		accessibility()
	}

	required init?(coder: NSCoder) {
		fatalError("NOT")
	}
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViewCode()
	}
}

extension CardCell: ViewCode {
	func hierarchy() {
		contentView.addSubview(containerStack)
	}
	func constraints() {
		containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
		containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
		containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero).isActive = true
		containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
	}
	func additional() {
		selectionStyle = .none
		containerStack.layer.cornerRadius = 12
		containerStack.clipsToBounds = true
	}
	func accessibility() {
		guard let data = index else { return }

		containerStack.accessibilityLabel = "item \(data)"
		containerStack.isAccessibilityElement = true

		bigLabel.accessibilityLabel = "big \(data)"
		bigLabel.accessibilityTraits = .header

		smallLabel.accessibilityLabel = "small \(data)"

		button.accessibilityLabel = "Button for \(data)"
		button.accessibilityTraits = .button

		accessibilityElements = [containerStack, containerStack.arrangedSubviews]
	}
}

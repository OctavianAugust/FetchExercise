//
//  ExpandableLabelView.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//
import UIKit

protocol ExpandableLabelViewDelegate: AnyObject {
    func expandableLabelViewHeightDidChange(_ view: ExpandableLabelView)
}

@IBDesignable
class ExpandableLabelView: UIView {

    weak var delegate: ExpandableLabelViewDelegate?

    private let titleLabel = UILabel()
    private let label = UILabel()
    private let toggleButton = UIButton(type: .system)

    private var isExpanded = false

    private var truncatedText: String {
        let maxLength = 100
        return fullText.count > maxLength ? String(fullText.prefix(maxLength)) + "..." : fullText
    }

    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    public var fullText: String = "" {
        didSet {
            label.text = truncatedText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        label.numberOfLines = 0
        label.text = truncatedText
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        toggleButton.setTitle("Read More", for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleText), for: .touchUpInside)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(toggleButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),

            toggleButton.topAnchor.constraint(equalTo: label.bottomAnchor),
            toggleButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            toggleButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        updateHeight()
    }

    @objc private func toggleText() {
        isExpanded.toggle()
        label.text = isExpanded ? fullText : truncatedText
        toggleButton.setTitle(isExpanded ? "Read Less" : "Read More", for: .normal)
        updateHeight()
    }

    private func updateHeight() {
        delegate?.expandableLabelViewHeightDidChange(self)
    }
}

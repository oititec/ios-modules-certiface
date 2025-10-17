//
//  ContentView.swift
//  Example
//

import UIKit

final class ContentView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CertifaceSDK"
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var providerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var defaultButton: UIButton = createButton(withTitle: "Padrão")
    lazy var customAppearanceButton: UIButton = createButton(withTitle: "Aparência customizada")
    lazy var customViewsButton: UIButton = createButton(withTitle: "Views customizadas")

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(providerLabel)
        addSubview(defaultButton)
        addSubview(customAppearanceButton)
        addSubview(customViewsButton)

        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

            providerLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            providerLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            providerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),

            defaultButton.leadingAnchor.constraint(equalTo: providerLabel.leadingAnchor),
            defaultButton.trailingAnchor.constraint(equalTo: providerLabel.trailingAnchor),
            defaultButton.topAnchor.constraint(equalTo: providerLabel.bottomAnchor, constant: 16),
            defaultButton.heightAnchor.constraint(equalToConstant: 60),

            customAppearanceButton.leadingAnchor.constraint(equalTo: defaultButton.leadingAnchor),
            customAppearanceButton.trailingAnchor.constraint(equalTo: defaultButton.trailingAnchor),
            customAppearanceButton.topAnchor.constraint(equalTo: defaultButton.bottomAnchor, constant: 20),
            customAppearanceButton.heightAnchor.constraint(equalTo: defaultButton.heightAnchor),

            customViewsButton.leadingAnchor.constraint(equalTo: defaultButton.leadingAnchor),
            customViewsButton.trailingAnchor.constraint(equalTo: defaultButton.trailingAnchor),
            customViewsButton.topAnchor.constraint(equalTo: customAppearanceButton.bottomAnchor, constant: 20),
            customViewsButton.heightAnchor.constraint(equalTo: defaultButton.heightAnchor),
        ])
    }

    public func createButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

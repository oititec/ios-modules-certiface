//
//  CustomIProovResultView.swift
//  Example
//

import CertifaceSDK
import UIKit

final class CustomIProovResultView: UIView, IProovCustomResultView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    lazy var retryButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        button.isEnabled = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(retryButton)

        NSLayoutConstraint.activate([
            retryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            retryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            retryButton.heightAnchor.constraint(equalToConstant: 50),
            retryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: retryButton.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: retryButton.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: -40)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(for resultType: IProovResultLayoutType, retryReason: String?) {
        switch resultType {
        case .success:
            backgroundColor = .green
        case .error:
            backgroundColor = .red
        case .retry:
            backgroundColor = .yellow
        @unknown default:
            backgroundColor = .white
        }
    }

    func changeLoadingVisibility(to visibility: Visibility) {
        switch visibility {
        case .displayed:
            titleLabel.text = "Loading: Displayed"
        case .hidden:
            fallthrough
        @unknown default:
            titleLabel.text = "Loading: Hidden"
        }
    }
}

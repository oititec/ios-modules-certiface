//
//  ContentViewController.swift
//  Example
//

import CertifaceSDK
import UIKit

final class ContentViewController: UIViewController {
    typealias ProviderBuilderClosure = (LivenessManagerOptions.Builder) -> LivenessManagerOptions

    private let customView = ContentView()
    private var provider: LivenessProvider = .iproov
    private let appKey = "APP_KEY"
    private let token = "TOKEN"
    private let environment: Environment = .hml
    private let showInstructionsScreen = true
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        configureElements()
    }

    private func configureElements() {
        customView.providerLabel.text = provider.rawValue.uppercased()
        customView.providerControl.addTarget(self, action: #selector(providerChanged(_:)), for: .valueChanged)
        customView.defaultButton.addTarget(self, action: #selector(defaultJourney), for: .touchUpInside)
        customView.customAppearanceButton.addTarget(self, action: #selector(customAppearanceJourney), for: .touchUpInside)
        customView.customViewsButton.addTarget(self, action: #selector(customViewsJourney), for: .touchUpInside)
    }

    @objc
    private func providerChanged(_ sender: UISegmentedControl) {
        provider = sender.selectedSegmentIndex == 0 ? .iproov : .saas
        customView.providerLabel.text = provider.rawValue.uppercased()
    }

    @objc
    private func defaultJourney() {
        switch provider {
        case .iproov:
            createJourney(with: IProovCustomizationExample.setDefaultAppearance(in:))
        case .saas:
            createJourney(with: SaasCustomizationExample.setDefaultAppearance(in:))
        @unknown default:
            fatalError("Provider not implemented")
        }
    }

    @objc
    private func customAppearanceJourney() {
        switch provider {
        case .iproov:
            createJourney(with: IProovCustomizationExample.setCustomAppearance(in:))
        case .saas:
            createJourney(with: SaasCustomizationExample.setCustomAppearance(in:))
        @unknown default:
            fatalError("Provider not implemented")
        }
    }

    @objc
    private func customViewsJourney() {
        switch provider {
        case .iproov:
            createJourney(with: IProovCustomizationExample.setCustomViews(in:))
        case .saas:
            createJourney(with: SaasCustomizationExample.setCustomViews(in:))
        @unknown default:
            fatalError("Provider not implemented")
        }
    }

    private func createJourney(with providerBuilder: @escaping ProviderBuilderClosure) {
        let builder: LivenessManagerOptions.Builder
        if provider == .iproov {
            builder = LivenessManagerOptions.builder(appKey: appKey, environment: environment)
        } else {
            builder = LivenessManagerOptions.builder(token: token, environment: environment)
        }
        _ = builder.setShowInstructionsScreen(showInstructionsScreen)
        let options = providerBuilder(builder)

        let manager = CertifaceSDKFactory.createLivenessManager(for: provider)
        manager.start(at: self, options: options, callback: self)
    }
}

// MARK: - LivenessCallback

extension ContentViewController: LivenessCallback {
    func onSuccess(_ result: LivenessResult) {
        let message = """
        Valid: \(String(describing: result.valid))
        CodId: \(String(describing: result.codId))
        Protocol: \(String(describing: result.protocol))
        """

        showAlert(title: "Resultado \(provider.rawValue.uppercased())", message: message)
    }

    func onError(_ error: LivenessError) {
        showAlert(
            title: "Resultado \(provider.rawValue.uppercased())",
            message: "[\(error.code)]: \(error.message)"
        )
    }

    private func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

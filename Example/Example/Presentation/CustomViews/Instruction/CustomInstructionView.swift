//
//  CustomIProovInstructionView.swift
//  Example
//

import CertifaceSDK
import UIKit

final class CustomInstructionView: UIView, LivenessCustomInstructionView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
        setupViews()
    }
    
    private func loadFromNib() {
        let classType = type(of: self)
        let bundle = Bundle(for: classType)
        bundle.loadNibNamed("\(classType)", owner: self)
    }
    
    private func setupViews() {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        
        addSubview(view)
    }
    
    func changeLoadingVisibility(to visibility: CertifaceSDK.Visibility) {
        switch visibility {
        case .displayed:
            activityIndicator.isHidden = false
        case .hidden:
            activityIndicator.isHidden = true
        @unknown default:
            activityIndicator.isHidden = true
        }
    }
}

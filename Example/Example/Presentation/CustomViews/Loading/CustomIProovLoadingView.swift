//
//  CustomIProovLoadingView.swift
//  Example
//

import CertifaceSDK
import UIKit

final class CustomIProovLoadingView: IProovCustomLoadingView {
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    private func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("\(type(of: self))", owner: self, options: nil)
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}

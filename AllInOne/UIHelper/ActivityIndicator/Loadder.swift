//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import UIKit
import Foundation

class Loadder {
    
    static let shared = Loadder()
    
    private init() {
    }
    
    let activityIndicatorView = ActivityIndicatorVC().view
    
    func showLoader(view: UIView) {
        view.addSubview(activityIndicatorView!)
        ActivityIndicatorManager.shared.showActivityIndicator()
    }
    
    func hideLoader() {
        activityIndicatorView?.removeFromSuperview()
    }
    
}

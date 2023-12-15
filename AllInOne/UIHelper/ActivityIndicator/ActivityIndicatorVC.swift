//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 05/12/23.
//

import Foundation
import SwiftUI

class ActivityIndicatorManager: ObservableObject {
    
    static let shared = ActivityIndicatorManager()

    @Published var isLoading = false

    private init() {}

    func showActivityIndicator() {
        isLoading = true
    }

    func hideActivityIndicator() {
        isLoading = false
    }
}

struct ActivityIndicatorView: View {
    
    @ObservedObject private var activityIndicatorManager = ActivityIndicatorManager.shared

    var body: some View {
        
        VStack(spacing: 24) {
            if activityIndicatorManager.isLoading {
                iActivityIndicator(style: .rotatingShapes(size:15))
            }
        }
        .frame(width: 200, height: 200)
        .padding()
        .foregroundColor(.mint)
    }
}

class ActivityIndicatorVC: UIViewController {
    
    private var hostingController: UIHostingController<ActivityIndicatorView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of UIHostingController with ContentView
        hostingController = UIHostingController(rootView: ActivityIndicatorView())

        // Add the SwiftUI view as a child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)

        // Set up constraints if necessary
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hostingController.didMove(toParent: self)
    }
}

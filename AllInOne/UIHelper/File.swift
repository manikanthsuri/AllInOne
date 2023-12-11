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
        if activityIndicatorManager.isLoading {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .frame(width: 120, height: 120)
                .background(Color.black.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}


struct ContentView: View {
    @ObservedObject private var activityIndicatorManager = ActivityIndicatorManager.shared

    var body: some View {
        ZStack {
            VStack {
                Text("Your Content Goes Here")

                Button("Show Activity Indicator") {
                    activityIndicatorManager.showActivityIndicator()
                }
            }

            if activityIndicatorManager.isLoading {
                ActivityIndicatorView()
                    .background(Color.black.opacity(0.5)) // Background to cover the entire view
            }
        }
    }
}
class MyViewController: UIViewController {
    
    private var hostingController: UIHostingController<ContentView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of UIHostingController with ContentView
        hostingController = UIHostingController(rootView: ContentView())

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

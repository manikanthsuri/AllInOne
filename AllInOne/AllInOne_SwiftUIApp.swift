//
//  AllInOne_SwiftUIApp.swift
//  AllInOne-SwiftUI
//
//  Created by Suri Manikanth on 11/12/23.
//

import SwiftUI

@main
struct AllInOne_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainTabbedView()
        }
    }
}

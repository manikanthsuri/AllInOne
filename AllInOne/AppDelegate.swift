//
//  File.swift
//  AllInOne-SwiftUI
//
//  Created by Suri Manikanth on 12/12/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        getConfigList()
        return true
    }
    
    func getConfigList() {
        
        FireBaseManager.shared.getConfigsList(completion: { result in
            switch result {
            case .success(let data):
                
                if let toAccountString = data["toAccount"] as? String {
                    toAccounts = toAccountString.components(separatedBy: ",")
                }
                
                if let fromAccountString = data["fromAccount"] as? String {
                    fromAccounts = fromAccountString.components(separatedBy: ",")
                }
                
                if let autoadd = data["showAutoAdd"] as? Bool {
                    showAutoAdd = autoadd
                }
                if let sampleRecord = data["sampleRecords"] as? [[String:Any]] {
                    sampleRecords = sampleRecord
                }
                
                if let allowEdit = data["allowSentItemEdit"] as? Bool {
                    allowSentItemEdit = allowEdit
                }
                
                if let allowDelete = data["allowSentItemDelete"] as? Bool {
                    allowSentItemDelete = allowDelete
                }
                
                if let bankAccountString = data["bankAccounts"] as? String {
                    bankAccounts = bankAccountString.components(separatedBy: ",")
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


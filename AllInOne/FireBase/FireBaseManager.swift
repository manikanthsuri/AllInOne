//
//  manager.swift
//  AllInOne
//
//  Created by Suri Manikanth on 20/11/23.
//

import Foundation
import FirebaseDatabase

final class FireBaseManager {
    
    static let shared = FireBaseManager()
    
    private init (){}
    private let database = Database.database().reference()
    lazy var tableRef = database.child(mainTable)

}



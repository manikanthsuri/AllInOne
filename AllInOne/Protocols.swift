//
//  Protocols.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 16/12/23.
//

import Foundation

@objc protocol dataAddUpdateProtocol {
    func dataAdded()
    @objc optional func dataUpdated()
}

@objc protocol filterProtocol {
    func filter(with filterDict:[String: [String]])
}

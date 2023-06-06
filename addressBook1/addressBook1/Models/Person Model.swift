//
//  ModelAddressBook.swift
//  addressBook1
//
//  Created by Briana Bayne on 6/5/23.
//

import Foundation

class Person: Codable {
    let id: UUID
    var name: String
    var address : String
    var isFavorite: Bool
    
    init(id: UUID = UUID(), name: String, address: String, isfavorite: Bool = false) {
        self.id = id
        self.name = name
        self.address = address
        self.isFavorite = isfavorite
    }
}

// MARK: - Extension
extension Person: Equatable {
    static func == (lhs: Person, rhs: Person ) -> Bool {
        return lhs.id == rhs.id
        
    }
}

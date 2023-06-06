//
//  Person Controller.swift
//  addressBook1
//
//  Created by Briana Bayne on 6/5/23.
//

import Foundation

class PersonController {
    
    // MARK: - Properties
    
    
    
    
    // MARK: - Functions Create, update, delete
    static func createPerson(name: String = "New Contact", address: String = "Contact Address", group: Group) {
        let person = Person(name: name, address: address)
        group.people.append(person)
        GroupController.shared.save()
        
        
    }
    static func deletePerson(person: Person, in group: Group) {
        guard let index = group.people.firstIndex(of: person) else
        { return }
        group.people.remove(at: index)
        GroupController.shared.save()
        
    }
    static func updatePerson(people: Person, name: String, address: String) {
        people.name = name
        people.address = address
        GroupController.shared.save()
        
    }
    static func toggleFavoite(person: Person) {
        person.isFavorite.toggle()
        GroupController.shared.save()
    }
}

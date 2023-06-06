//
//  GroupController.swift
//  addressBook1
//
//  Created by Briana Bayne on 6/5/23.
//

import Foundation

class GroupController {
    
    // MARK: - Properties
    static let shared = GroupController()
    private(set) var groups: [Group] = []
    
    init() {
        load()
        
    }
    
    // MARK: - Functions (Create,Read, Update, Delete)
    
    func createGroup(name: String = "Untitled Group", people: [Person] = []) {
        let group = Group(name: name)
        groups.append(group)
        save()
        
    }
    
    func updateGroup(group: Group, name: String){
        group.name = name
        save()
    }

    func deleteGroup(group: Group) {
        guard let index = groups.firstIndex(of: group)
        else { return }
        groups.remove(at: index)
        save()
    }
    // MARK: - Persistence
    func save() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(groups)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let categories = try JSONDecoder().decode([Group].self, from: data)
            self.groups = categories
        } catch {
            print(error)
        }
    }
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {return nil}
        let url = documentsDirectory.appendingPathComponent("group.json")
        return url
    }
}




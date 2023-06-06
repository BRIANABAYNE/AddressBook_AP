//
//  GroupTableViewController.swift
//  addressBook1
//
//  Created by Briana Bayne on 6/5/23.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
  
    
    // MARK: - Properties
    let groupController = GroupController.shared
    
    // MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupController.groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = groupController.groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = "\(group.people.count) Contacts"
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let group = groupController.groups[indexPath.row]
            groupController.deleteGroup(group: group)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    // MARK: - Navigatio IIDOO
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPeopleTableViewVC",
              let destinationVC = segue.destination as?
                PeopleTableViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        let group = groupController.groups[selectedRow]
        destinationVC.group = group
    }
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        
        groupController.createGroup()
        tableView.reloadData()
    }
    
}


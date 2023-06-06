//
//  PeopleTableViewController.swift
//  addressBook1
//
//  Created by Briana Bayne on 6/5/23.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    // MARK: - Properties
    var group: Group?
    
    private var filteredPeople: [Person] {
        if switchButton.isOn {
            return group?.people.filter { $0.isFavorite } ?? []
        } else {
            return group?.people ?? []
        }
        
    }
    
    
    // MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupNameTextField.text = group?.name
        switchButton.isOn = false
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let group = group,
              let newName = groupNameTextField.text
        else { return }
        GroupController.shared.updateGroup(group: group, name: newName)
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredPeople.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell()}
        let person = filteredPeople [indexPath.row]
        cell.person = person
        cell.delegate = self
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = group else { return }
            let person = filteredPeople[indexPath.row]
            PersonController.deletePerson(person: person, in: group)
           
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        }

            // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let group = group else { return }
        PersonController.createPerson(group: group)
        tableView.reloadData()
    }
    @IBAction func switchButtonToggle(_ sender: Any) {
        tableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailVC",
              let personDetailVC = segue.destination as? PersonDetailViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row
        else { return }
        let person = filteredPeople[selectedRow]
        personDetailVC.person = person 
    }
}
// MARK: - FavoriteTableViewCellDelegate conformance
extension PeopleTableViewController: FavoriteTableViewCellDelegate {
    func toggleFavoriteButtonTapped(cell: FavoriteTableViewCell) {
        guard let person = cell.person else { return }
        PersonController.toggleFavoite(person: person)
        tableView.reloadData()
    }
}

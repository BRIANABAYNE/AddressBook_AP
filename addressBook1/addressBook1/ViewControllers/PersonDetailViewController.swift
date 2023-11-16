//
//  PersonDetailViewController.swift
//  addressBook1
//
//  Created by Briana Bayne on 6/5/23.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: - Properties
    var person: Person?
   
    // MARK: - Lifecyle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let person = person else { return }
        nameTextField.text = person.name
        addressTextField.text = person.address
    }
    func updateFavoriteButton() {
        guard let person = person else { return }
        let favoriteImageName = person.isFavorite ? "moons.stars.fill" : "moon.stars"
        let image = UIImage(systemName : favoriteImageName)
        favoriteButton.image = image
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let person = person,
              let name = nameTextField.text,
              let address = addressTextField.text else { return }
        PersonController.updatePerson(people: person, name: name, address: address)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let person = person else { return }
        PersonController.toggleFavoite(person: person)
        updateFavoriteButton()
    }
}

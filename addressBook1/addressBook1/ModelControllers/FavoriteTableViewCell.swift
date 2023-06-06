//
//  FavoriteTableViewCell.swift
//  addressBook1
//
//  Created by Briana Bayne on 6/6/23.
//

import UIKit

protocol FavoriteTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonTapped(cell: FavoriteTableViewCell)
}
    
class FavoriteTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
// MARK: - Properties
    weak var delegate: FavoriteTableViewCellDelegate?
    var person : Person? {
        didSet {
            updateUI()
        }
    }
    // MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        delegate?.toggleFavoriteButtonTapped(cell: self)
    }
    
    // MARK: - Functions // LOOK 
    func updateUI() {
        guard let person = person else { return }
        nameLabel.text = person.name
        let image = UIImage(systemName: person.isFavorite ? "moon.stars.fill" : "moon.stars")
        favoriteButton.setImage(image, for: .normal)
        
    }
    
    
    }
    
    



//
//  SelectedDataTableViewCell.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import UIKit

class SelectedDataTableViewCell: UITableViewCell {

    //MARK: - Outlet Connections
    @IBOutlet weak var selectedKeyLabel: UILabel!
    @IBOutlet weak var selectedValueLabel: UILabel!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Support Functions
    func configure(with key: String, and value: String) {
        selectedKeyLabel.text = key
        selectedValueLabel.text = value
    }
    
}

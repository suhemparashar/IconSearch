//
//  IconSearchCellVC.swift
//  IconSearch
//
//  Created by suhemparashar on 28/05/23.
//

import UIKit

class IconSearchCellVC: UITableViewCell {

    @IBOutlet weak var iconPreview: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

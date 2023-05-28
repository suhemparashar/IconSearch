//
//  IconCellVC.swift
//  IconSearch
//
//  Created by suhemparashar on 27/05/23.
//

import UIKit

protocol IconCellVCDelegate {
    func buttonClicked(rasterSizes: [RasterSizes]?)
}
class IconCellVC: UITableViewCell {
    
    @IBOutlet weak var iconPreview: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
  
    var rasterSizes: [RasterSizes]? = []
    var delegate: IconCellVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        if actionButton.titleLabel?.text == "  Download"{
            delegate?.buttonClicked(rasterSizes: rasterSizes)
        }
    }
}


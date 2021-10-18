//
//  CustomTableViewCell.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/09/14.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var CustomCell: UIView!
    @IBOutlet weak var drinknameLabel: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        drinkImage.layer.cornerRadius = 20.0
        CustomCell.layer.cornerRadius = 20.0
        CustomCell.layer.shadowOffset = CGSize(width: 0, height: 1)
        CustomCell.layer.shadowOpacity = 0.2
        CustomCell.layer.shadowRadius = 20.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
}

//
//  CustomTableViewCell.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/09/14.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var drinknameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

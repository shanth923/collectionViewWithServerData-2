//
//  TableViewCell.swift
//  collectionViewWithServerData
//
//  Created by R Shantha Kumar on 1/6/20.
//  Copyright © 2020 R Shantha Kumar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageVie: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

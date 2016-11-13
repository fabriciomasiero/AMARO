//
//  FMAMProductCellTableViewCell.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit

class FMAMProductCellTableViewCell: UITableViewCell {

    @IBOutlet var imgProduct: UIImageView!
    
    @IBOutlet var lblProductName: UILabel!
    
    @IBOutlet var lblProductPrice: UILabel!
    
    @IBOutlet var btnProductSize: UIButton!
    
    @IBOutlet var btnProductQuantity: UIButton!
    
    @IBOutlet var imgSize: UIImageView!
    
    @IBOutlet var imgQuantity: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

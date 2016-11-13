//
//  FMAMCartCellTableViewCell.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit

class FMAMCartCellTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var imgProduct: UIImageView!
    
    @IBOutlet var lblProductName: UILabel!
    
    @IBOutlet var lblProductSize: UILabel!
    
    @IBOutlet var btnProductQuantity: UIButton!

    @IBOutlet var lblProductPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

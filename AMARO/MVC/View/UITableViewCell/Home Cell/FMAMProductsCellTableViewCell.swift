//
//  FMAMProductsCellTableViewCell.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit

class FMAMProductsCellTableViewCell: UITableViewCell {

    @IBOutlet var imgProduct: UIImageView!
    
    @IBOutlet var lblProductName: UILabel!
    
    @IBOutlet var lblProductsSize: UILabel!
    
    @IBOutlet var lblProductsPrice: UILabel!
    
    @IBOutlet var viewRibbon: UIView!
    
    @IBOutlet var imgRibbonDiscount: UIImageView!
    
    @IBOutlet var lblRibbonDiscount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgRibbonDiscount.alpha = 0.85
        //OLD REDESIGNING A VIEW RIBBON - failed
//        let color: UIColor = UIColor.init(colorLiteralRed: 44.0/255.0, green: 173.0/255.0, blue: 224.0/255.0, alpha: 1.0)
//        self.viewRibbon.backgroundColor = color.withAlphaComponent(0.8)
//        let shapeLayer: CAShapeLayer = CAShapeLayer.init()
//        let bezierPath: UIBezierPath = UIBezierPath.init()
//        
//        bezierPath.move(to: CGPoint(x: 0, y: 0))
//        bezierPath.addLine(to: CGPoint(x: 40, y: 40))
//        bezierPath.addLine(to: CGPoint(x: 40, y: 0))
//        
//        bezierPath.close()
//        
//        
//        
//        shapeLayer.path = bezierPath.cgPath
//        
//        shapeLayer.fillColor = UIColor.red.withAlphaComponent(0).cgColor
//        
//        
//        self.viewRibbon.layer.addSublayer(shapeLayer)
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

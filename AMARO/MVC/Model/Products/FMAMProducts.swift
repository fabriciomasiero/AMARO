//
//  FMAMProducts.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit

class FMAMProducts: NSObject {
    
    
    // MARK: Propertys
    public var name: String!
    public var style: String!
    public var codeColor: String!
    public var colorSlug: String!
    public var color: String!
    public var onSale: Bool
    public var regularPrice: String!
    public var actualPrice: String!
    public var discountPorcentage: String!
    public var installments: String!
    public var pictureUrl: URL!
    public var rawPrice: Float
    public var sizes : NSArray!
    public var sizeSelected: FMAMSizes!
    public var quantity: Int!
    
    //sem id, vem as GAMBS
    public var onCart: Bool
    
    // MARK: Init
    init(dictionary: NSDictionary) {
        self.name = dictionary.value(forKey: "name") as! String!
        self.style = dictionary.value(forKey: "style") as! String!
        self.codeColor = dictionary.value(forKey: "code_color") as! String!
        self.colorSlug = dictionary.value(forKey: "color_slug") as! String!
        self.color = dictionary.value(forKey: "color") as! String!
        self.onSale = dictionary.value(forKey: "on_sale") as! Bool!
        self.regularPrice = dictionary.value(forKey: "regular_price") as! String!
        self.actualPrice = dictionary.value(forKey: "actual_price") as! String!
        self.discountPorcentage = dictionary.value(forKey: "discount_percentage") as! String!
        self.installments = dictionary.value(forKey: "installments") as! String!
        let pict = dictionary.value(forKey: "image") as! String!
        self.pictureUrl = URL.init(string: pict!)
        
        
        let allMutableSizes: NSMutableArray = NSMutableArray.init()
        for size in dictionary.value(forKey: "sizes") as! NSArray! {
            allMutableSizes.add(FMAMSizes.init(dictionary: size as! NSDictionary))
        }
        self.sizes = NSArray.init(array: allMutableSizes)
        
        var price: String = self.regularPrice
        if (actualPrice.characters.count > 0) {
            price = self.actualPrice
        }
        price = price.replacingOccurrences(of: "R$ ", with: "")
        price = price.replacingOccurrences(of: ",", with: ".")
        self.rawPrice = Float(price)!
        self.sizeSelected = nil
        self.quantity = 0
        self.onCart = false
    }
    
    
    // MARK: Attributed Price
    public func getAttributedPrice() -> NSMutableAttributedString {
        
        let lenghtRegularPrice: Int = self.regularPrice.characters.count as Int
        let lenghtActualPrice: Int = self.actualPrice.characters.count as Int
        
        let rangeRegular: NSRange = NSRange(location: 0, length: lenghtRegularPrice)
        let rangeActual: NSRange = NSRange(location: lenghtRegularPrice + 1, length: lenghtActualPrice)
        
        let mutableString: NSMutableAttributedString = NSMutableAttributedString.init(string: self.regularPrice + " " + self.actualPrice)
        
        let myAttributeLower = [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 10)]
        let myAttributeUpper = [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 18)]
        let myAttributeLowerColor = [NSForegroundColorAttributeName:UIColor.darkGray]
        let myAttributeUpperColor = [NSForegroundColorAttributeName:UIColor.black]
        let myAttributeStrikeLower = [NSStrikethroughStyleAttributeName:1]
        
        mutableString.addAttributes(myAttributeLowerColor, range: rangeRegular)
        mutableString.addAttributes(myAttributeLower, range: rangeRegular)
        
        mutableString.addAttributes(myAttributeStrikeLower, range: rangeRegular)
        
        mutableString.addAttributes(myAttributeUpper, range: rangeActual)
        mutableString.addAttributes(myAttributeUpperColor, range: rangeActual)
        
        return mutableString
        
    }
}

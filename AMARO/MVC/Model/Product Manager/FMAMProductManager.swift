//
//  FMAMProductManager.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit

class FMAMProductManager: NSObject {
    public static let shared = FMAMProductManager()
    
    public func insertProductToCart(product: FMAMProducts, products: NSArray) {
        let predicate = NSPredicate(format: "name == %@ AND onCart == true", product.name)
        let sortedByOnCart = (products as NSArray).filtered(using: predicate) as NSArray
        
        if (sortedByOnCart.count > 0) {
            let prod: FMAMProducts = sortedByOnCart.firstObject as! FMAMProducts
            prod.quantity = product.quantity
            prod.sizeSelected = product.sizeSelected
        } else {
            product.onCart = true
        }
    }
    
    public func removeProductOfCart(product: FMAMProducts) {
        product.onCart = false
        product.quantity = 0
        product.sizeSelected = nil
        
    }
    
    public func retrieveProductsOnCart(products: NSArray) -> NSArray {
        let predicate = NSPredicate(format: "onCart == true")
        let sortedByOnCart = (products as NSArray).filtered(using: predicate) as NSArray
        
        return sortedByOnCart
    }
    
    public func retrieveProductsOnCartCount(products: NSArray) -> Int {
        return self.retrieveProductsOnCart(products: products).count
    }

}

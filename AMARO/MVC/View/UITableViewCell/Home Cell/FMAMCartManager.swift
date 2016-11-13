//
//  FMAMCartManager.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit
import CoreDataServices
import CoreData

class FMAMCartManager: NSObject {
    
    
    public static let shared = FMAMCartManager()
    
    public func insertOrUpdateCart(product:FMAMProducts) {
        
        
        let cart = self.checkIfExistsItemInCart(name: product.name, size: product.sizeSelected.size)
        
        if (cart != nil) {
            
            cart?.name = product.name
            cart?.size = product.sizeSelected.size
            cart?.actualPrice = product.actualPrice
            cart?.regularPrice = product.regularPrice
            cart?.rawPrice = product.rawPrice * Float(product.quantity)
            cart?.color = product.color
            cart?.colorSlug = product.colorSlug
            cart?.codeColor = product.codeColor
            cart?.quantity = Int32(product.quantity)
            cart?.onSale = product.onSale
            cart?.installments = product.installments
            cart?.discountPercentage = product.discountPorcentage
            cart?.style = product.style
            
        } else {
            let newCart = NSEntityDescription.insertNewObject(entityClass: Cart.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
            newCart.name = product.name
            newCart.size = product.sizeSelected.size
            newCart.actualPrice = product.actualPrice
            newCart.regularPrice = product.regularPrice
            newCart.rawPrice = product.rawPrice * Float(product.quantity)
            newCart.color = product.color
            newCart.colorSlug = product.colorSlug
            newCart.codeColor = product.codeColor
            newCart.quantity = Int32(product.quantity)
            newCart.onSale = product.onSale
            newCart.installments = product.installments
            newCart.discountPercentage = product.discountPorcentage
            newCart.style = product.style
        }
       
        ServiceManager.sharedInstance.saveMainManagedObjectContext()
    }
    
    
    // MARK: Check If File Exists
    public func checkIfExistsItemInCart(name: String, size: String) -> Cart! {
        
        // sem id do produto, ai vai na gambs
        let predicate = NSPredicate(format: "name == %@ AND size == %@", name, size)
        
        let sort = self.retrieveAllCarts().filtered(using: predicate) as NSArray
        
        if (sort.count > 0) {
            let product: Cart = sort.firstObject as! Cart
            return product
        } else {
            return nil
        }
    }
    
    public func deleteCart(cart: Cart) -> Bool {
        let initialCount: Int = self.retriveNumberOfCarts()
        let quantity = cart.quantity
        
        let predicate = NSPredicate(format: "name == %@ AND quantity == \(quantity) AND size == %@", cart.name!, cart.size!)
        ServiceManager.sharedInstance.mainManagedObjectContext.deleteEntries(entityClass: Cart.self, predicate: predicate)
        ServiceManager.sharedInstance.saveMainManagedObjectContext()
        
        let finalCount: Int = self.retriveNumberOfCarts()
        
        if (initialCount > finalCount) {
            return true
        }
        return false
    }
    // MARK: Retrive Infos
    public func retrieveAllCarts() -> NSArray {
        let carts = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Cart.self, sortDescriptors: [])
        
        return carts as NSArray
    }
    
    // MARK: Count Of Infos
    public func retriveNumberOfCarts() -> Int {
        let totalCarts = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Cart.self)
        return totalCarts
    }
}

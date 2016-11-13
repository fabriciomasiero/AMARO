//
//  FMAMParser.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit

class FMAMParser: NSObject {
    
    public func getProducts() -> NSArray {
        let allProducts: NSMutableArray = NSMutableArray.init();
        let path = Bundle.main.path(forResource: "products", ofType: "json")
        if (path != nil) {
            
            let pathUrl :URL! = URL (fileURLWithPath: path!);
            
            let jsonData = try? Data (contentsOf: pathUrl)
            
            
            if (jsonData != nil) {
                
                if let json = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers) {
                    if let jsonDictionary: NSDictionary = json as? NSDictionary {
                        print(jsonDictionary);
                        let products: NSArray = jsonDictionary.value(forKey: "products") as! NSArray!
                        print(products)
                        
                        
                        for dic in products {
                            allProducts.add(FMAMProducts.init(dictionary: dic as! NSDictionary))
                        }
                        
                    }
                }
            }
        }
        
        
        return NSArray.init(array: allProducts)
    }

}

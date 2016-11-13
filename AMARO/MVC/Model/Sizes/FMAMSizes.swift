//
//  FMAMSizes.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit

class FMAMSizes: NSObject {
    
    public var available: Bool!
    public var size: String!
    public var sizeToShow: String!
    public var sku: String!
    
    init(dictionary: NSDictionary) {
        self.available = dictionary.value(forKey: "available") as! Bool!
        self.size = dictionary.value(forKey: "size") as! String!
        self.sku = dictionary.value(forKey: "sku") as! String!
        
        if (self.available == false) {
            self.sizeToShow = self.size + "(Não disponível)"
        } else {
            self.sizeToShow = self.size
        }
    }
}

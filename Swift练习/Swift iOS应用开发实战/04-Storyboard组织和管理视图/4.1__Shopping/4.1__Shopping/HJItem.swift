//
//  HJItem.swift
//  4.1__Shopping
//
//  Created by M-coppco on 16/6/19.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class HJItem: NSObject {
    var itemName : String? = ""
    var itemBrand : String? = ""
    var isBuy : Bool = false
    
    
    init(itemName: String, itemBrand: String, isBuy: Bool) {
        self.itemName = itemName
        self.itemBrand = itemBrand
        self.isBuy = isBuy
    }
    
    convenience init(itemName: String) {
        self.init(itemName:itemName, itemBrand:"", isBuy:false)
    }
    convenience init(itemName: String, itemBrand: String) {
        self.init(itemName:itemName, itemBrand:itemBrand, isBuy:false)
    }
    
    func  description1()->String {
        return "itemName: \(itemName) itemBrand:\(itemBrand) isBuy: \(isBuy)"
    }
}

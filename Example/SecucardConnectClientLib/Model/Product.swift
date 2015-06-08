//
//  Product.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 02.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit
import SwiftyJSON

class Product: NSObject {

  var data: JSON?
  
  var name: String {
    get {
      
      if let d = data {
        return d["title"].stringValue
      } else {
        return ""
      }
      
    }
  }
  
  var articleNumber: String {
    get {
      if let d = data {
        return d["object"]["number"].stringValue
      } else {
        return ""
      }
    }
  }
  
  var price: Float {
    get {
      if let d = data {
        return d["object"]["sale"][0]["price"].floatValue
      } else {
        return 0.0
      }
    }
  }
  
  var imageName: String {
    get {
      if let d = data {
        return d["object"]["images"][0]["file"].stringValue+".jpg"
      } else {
        return ""
      }
    }
  }
  
  convenience init(product : JSON) {
    
    self.init()
    data = product
    
  }
  
}

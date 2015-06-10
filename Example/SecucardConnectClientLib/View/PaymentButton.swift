//
//  PaymentButton.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 04.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit

class PaymentButton: UIButton {

  var target: AnyObject? {
    didSet {
      addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
  }
  var action: Selector = ""
  
  convenience init(title: String, action: Selector) {
    
    self.init()
    
    self.action = action
    
    setTitle(title, forState: UIControlState.Normal)

    backgroundColor = Constants.tintColor
    tintColor = Constants.textColorBright
    
    
  }
  
}

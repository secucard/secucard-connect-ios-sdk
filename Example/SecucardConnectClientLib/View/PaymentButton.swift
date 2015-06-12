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
  
  var payMethod:PayMethod = PayMethod.Unset
  var action: Selector = ""
  
  init() {
    super.init(frame: CGRectNull)
    backgroundColor = Constants.tintColor
    tintColor = Constants.textColorBright
  }
  
  convenience init(title: String, action: Selector) {
    
    self.init()
    self.action = action
    setTitle(title, forState: UIControlState.Normal)
    
  }

  convenience init(icon: String, action: Selector) {
    
    self.init()
    self.action = action
    self.setImage(UIImage(named: icon), forState: UIControlState.Normal)
    
  }
  
  convenience init(payMethod: PayMethod, action: Selector) {
    
    self.init()
    self.action = action
    self.payMethod = payMethod
    setTitle(payMethod.rawValue, forState: UIControlState.Normal)
    
  }
  
  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}

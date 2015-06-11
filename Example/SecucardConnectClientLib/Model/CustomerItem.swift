//
//  CustomerItem.swift
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 10.06.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

import UIKit
import SecucardConnectClientLib

enum CustomerType {
  
  case CardCustomer
  case CheckinCustomer
  
}

class CustomerItem: NSObject {

  var type: CustomerType?
  var checkin: SCSmartCheckin?
  var cardNumber: String?
  
  override init() {
    super.init()
  }
  
  convenience init(checkin:SCSmartCheckin) {
    
    self.init()
    type = CustomerType.CheckinCustomer
    self.checkin = checkin
    
  }
  
  convenience init(number:String) {
    
    self.init()
    type = CustomerType.CardCustomer
    cardNumber = number
    
  }
  
  convenience init(account:SCGeneralAccount) {
    
    self.init()
    type = CustomerType.CardCustomer
    
    if let customerName = account.contact.name {
      cardNumber = account.contact.name
    } else {
      cardNumber = "n/a"
    }
    
  }
}

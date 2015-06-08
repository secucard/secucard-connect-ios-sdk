//
//  AccountManager.swift
//  Pods
//
//  Created by Jörn Schmidt on 07.06.15.
//
//

class AccountManager: NSObject {

  var clientCredentials: ClientCredentials?
  var userCredentials: UserCredentials?
  
  override init() {
    super.init()
  }
  
  convenience init(clientCredentials: ClientCredentials) {
    
    self.init()
    self.clientCredentials = clientCredentials
    
  }
  
  func login(userCredentials: UserCredentials) {
    
  }
  
  func token() {
    
  }
  
}

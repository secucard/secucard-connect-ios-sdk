//
//  ConnectClient.swift
//  Pods
//
//  Created by Jörn Schmidt on 07.06.15.
//
//

class ConnectClient: NSObject
{
  
  static let sharedInstance = ConnectClient()
  
  private var configuration: ClientConfiguration?
  var connected: Bool = false
  
  override init() {
    super.init()
  }
  
  convenience init(configuration: ClientConfiguration) {
    
    
    self.init()
    self.configuration = configuration
    
  }
  
  func connect () {
    
  }
  
  func disconnect () {
    
  }
  
}

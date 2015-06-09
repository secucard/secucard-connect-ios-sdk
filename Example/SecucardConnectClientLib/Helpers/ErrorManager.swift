//
//  ErrorManager.swift
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 09.06.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

import SecucardConnectClientLib

class ErrorManager: SCErrorManager {

  override static func handleError(error: NSError) {
    
    super.handleError(error)
    
    let alert:UIAlertView = UIAlertView(title: "Fehler", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
    alert.show()
    
  }
  
}

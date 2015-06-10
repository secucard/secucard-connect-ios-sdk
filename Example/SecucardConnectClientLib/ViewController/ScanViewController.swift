//
//  ScanViewController.swift
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 09.06.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

import UIKit
import TFBarcodeScanner

protocol ScanViewControllerDelegate {
  func scanViewFoundCode(barcodes: Set<NSObject>!)
}

class ScanViewController: TFBarcodeScannerViewController {

  var delegate: ScanViewControllerDelegate?
  
  override func barcodeWasScanned(barcodes: Set<NSObject>!) {
    
    self.delegate?.scanViewFoundCode(barcodes)
    
  }

}

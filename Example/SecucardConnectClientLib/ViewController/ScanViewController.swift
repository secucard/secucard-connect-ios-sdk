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
  func scanViewReturnCode(code: String)
}

class ScanViewController: TFBarcodeScannerViewController, ScanCardViewDelegate {

  var delegate: ScanViewControllerDelegate?
  var scanCardView: ScanCardView = ScanCardView()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    barcodeTypes = 0x200
    
    scanCardView.delegate = self
    
  }
  
  override func barcodePreviewWillShowWithDuration(duration: CGFloat) {
    
    view.addSubview(scanCardView)
    
    scanCardView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(view)
    }
    
  }
  
  override func barcodePreviewWillHideWithDuration(duration: CGFloat) {
    
    scanCardView.removeFromSuperview()
    
  }
  
  override func barcodeWasScanned(barcodes: Set<NSObject>!) {
    
    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    
    if let barcode: TFBarcode = barcodes.first as? TFBarcode {
      scanCardView.numberField.text = barcode.string
      delegate?.scanViewReturnCode(barcode.string)
    }
    
  }

  // MARK: - ScanCardViewDelegate
  func scanCardFinished(code: String) {
    delegate?.scanViewReturnCode(code)
  }
  
}

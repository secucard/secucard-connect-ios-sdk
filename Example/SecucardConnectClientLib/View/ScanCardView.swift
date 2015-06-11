//
//  ScanCardView.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 05.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit

protocol ScanCardViewDelegate {
  func scanCardFinished(code:String)
}

class ScanCardView: UIView {

  let scanImageView: UIImageView = UIImageView(image: UIImage(named: "scan"))
  let titleLabel: UILabel = UILabel()
  let numberField: UITextField = UITextField()
  
  var delegate: ScanCardViewDelegate?
  
  init() {
    
    super.init(frame: CGRectNull)
    
    alpha = 0;
    
    let centerView = UIView()
    centerView.backgroundColor = UIColor.whiteColor()
    addSubview(centerView)
    
    centerView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.top.equalTo(80)
      make.width.equalTo(600)
      make.height.equalTo(200)
    }
    
    centerView.addSubview(scanImageView)
    
    scanImageView.snp_makeConstraints { (make) -> Void in
      make.top.left.equalTo(10)
      make.height.equalTo(120)
      make.width.equalTo(200)
    }
    
    titleLabel.font = Constants.headlineFont
    titleLabel.textColor = Constants.textColor
    titleLabel.text = "Bitte scannen Sie jetzt Ihre Karte"
    centerView.addSubview(titleLabel)
    
    titleLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(centerView).offset(10)
      make.left.equalTo(scanImageView.snp_right).offset(20)
      make.right.equalTo(centerView).offset(-20)
      make.height.equalTo(40)
    }
    
    numberField.placeholder = "secucard Kartennummer"
    numberField.borderStyle = UITextBorderStyle.Line
    centerView.addSubview(numberField)
    
    numberField.snp_makeConstraints { (make) -> Void in
      make.left.right.height.equalTo(titleLabel)
      make.top.equalTo(titleLabel.snp_bottom).offset(20)
    }
    
    let cancelButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    cancelButton.setTitle("Abbrechen", forState: UIControlState.Normal)
    cancelButton.addTarget(self, action: "didTapCancel", forControlEvents: UIControlEvents.TouchUpInside)
    cancelButton.backgroundColor = Constants.brightGreyColor
    centerView.addSubview(cancelButton)
    
    cancelButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.width.equalTo(100)
      make.height.equalTo(50)
      make.bottom.equalTo(-10)
    }
    
    let okButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    okButton.setTitle("OK", forState: UIControlState.Normal)
    okButton.addTarget(self, action: "didTapOK", forControlEvents: UIControlEvents.TouchUpInside)
    okButton.backgroundColor = Constants.tintColor
    centerView.addSubview(okButton)
    
    okButton.snp_makeConstraints { (make) -> Void in
      make.right.equalTo(-10)
      make.width.equalTo(100)
      make.height.equalTo(50)
      make.bottom.equalTo(-10)
    }
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
      self.alpha = 1
    })
    
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func didTapOK() {
    
    if (numberField.text != "") {
      delegate?.scanCardFinished(numberField.text)
    }
    
  }
  
  func didTapCancel() {
    
    delegate?.scanCardFinished(numberField.text)
    
  }
  
  func hide() {
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
      
      self.alpha = 0
      
      }) { (done) -> Void in
        
        self.removeFromSuperview()
        
    }
  }
  
}

//
//  ModifyPriceView.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 03.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit

enum PriceChangeType {
  
  case Price
  case Discount
  
}

protocol ModifyPriceViewDelegate {
  
  func priceViewChangedPrice(price: Float)
  func priceViewAddedDiscount(discount: Float)
  
}

class ModifyPriceView: UIView {
  
  var type: PriceChangeType?
  var delegate: ModifyPriceViewDelegate?
  
  let priceField: UITextField = UITextField()
  let typeLabel: UILabel = UILabel()
  
  override init (frame : CGRect) {
    super.init(frame : frame)
    setupView()
  }
  
  convenience init (type: PriceChangeType) {
    self.init(frame:CGRectZero)
    self.type = type
    typeLabel.text = (type == PriceChangeType.Price) ? "€" : "%"
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  func setupView() {
    
    alpha = 0;
    
    backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
    
    let centerView: UIView = UIView()
    centerView.backgroundColor = UIColor.whiteColor()
    addSubview(centerView)
    
    centerView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.top.equalTo(80)
      make.width.equalTo(400)
      make.height.equalTo(200)
    }
    
    var titleLabel: UILabel = UILabel()
    titleLabel.text = "Preisänderungen des Artikels"
    titleLabel.font = UIFont.systemFontOfSize(24)
    centerView.addSubview(titleLabel)
    
    titleLabel.snp_makeConstraints { (make) -> Void in
      make.top.left.equalTo(10)
      make.right.equalTo(-10)
      make.height.equalTo(30)
    }
    
    priceField.keyboardType = UIKeyboardType.NumberPad
    priceField.borderStyle = UITextBorderStyle.Line
    priceField.font = UIFont.systemFontOfSize(36)
    centerView.addSubview(priceField)
    
    priceField.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.right.equalTo(-80)
      make.top.equalTo(titleLabel.snp_bottom).offset(20)
      make.height.equalTo(50)
    }
    
    if let theType = type {
      typeLabel.text = (theType == PriceChangeType.Price) ? "€" : "%"
    }
    typeLabel.font = UIFont.systemFontOfSize(24)
    centerView.addSubview(typeLabel)
    
    typeLabel.snp_makeConstraints { (make) -> Void in
      make.top.bottom.equalTo(priceField)
      make.right.equalTo(-10)
      make.left.equalTo(priceField.snp_right).offset(10)
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
    
    priceField.becomeFirstResponder()
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
      self.alpha = 1
    })
    
  }
  
  func didTapOK() {
    
    if let theType = type {
      
      switch theType {
        
      case PriceChangeType.Price:
        if let theDelegate = delegate {
          theDelegate.priceViewChangedPrice((self.priceField.text as NSString).floatValue)
        }
        
      case PriceChangeType.Discount:
        if let theDelegate = delegate {
          theDelegate.priceViewAddedDiscount((self.priceField.text as NSString).floatValue)
        }
      }
      
      hide()
      
    }
    
  }
  
  func didTapCancel() {
    
    hide()
  }
  
  func hide() {
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
      
      self.alpha = 0
      
    }) { (done) -> Void in
      
      self.removeFromSuperview()
      
    }
  }
  
}

//
//  InitializationView.swift
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 11.06.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

import UIKit

protocol InitializationViewDelegate {
  func didSaveCredentials()
}

class InitializationView: UIView {

  let clientIdField = UITextView()
  let clientSecretField = UITextView()
  let uuidField = UITextView()
  
  var delegate: InitializationViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
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
      make.width.equalTo(500)
      make.height.equalTo(300)
      make.centerX.centerY.equalTo(self)
    }
    
    var titleLabel: UILabel = UILabel()
    titleLabel.text = "Kasseneinstellungen"
    titleLabel.font = UIFont.systemFontOfSize(24)
    centerView.addSubview(titleLabel)
    
    titleLabel.snp_makeConstraints { (make) -> Void in
      make.top.left.equalTo(20)
      make.right.equalTo(-20)
      make.height.equalTo(30)
    }
    
    let clientIdLabel = UILabel()
    clientIdLabel.text = "Client Id"
    clientIdLabel.font = Constants.headlineFont
    centerView.addSubview(clientIdLabel)
    
    clientIdLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(20)
      make.top.equalTo(titleLabel.snp_bottom).offset(20)
      make.width.equalTo(100)
      make.height.equalTo(30)
    }
    
    clientIdField.font = Constants.headlineFont
    clientIdField.layer.borderWidth = 1
    clientIdField.layer.borderColor = Constants.darkGreyColor.CGColor

    if let clientId = NSUserDefaults.standardUserDefaults().objectForKey(DefaultsKeys.ClientId.rawValue) as? String {
      clientIdField.text = clientId
    } else {
      clientIdField.text = Constants.clientIdCashierSample
    }
    
    centerView.addSubview(clientIdField)
    
    clientIdField.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(clientIdLabel.snp_right).offset(20)
      make.top.equalTo(clientIdLabel)
      make.right.equalTo(-20)
      make.height.equalTo(30)
    }
    
    // client secret
    
    let clientSecretLabel = UILabel()
    clientSecretLabel.text = "Client Secret"
    clientSecretLabel.font = Constants.headlineFont
    centerView.addSubview(clientSecretLabel)
    
    clientSecretLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(20)
      make.top.equalTo(clientIdLabel.snp_bottom).offset(20)
      make.width.equalTo(100)
      make.height.equalTo(30)
    }
    
    clientSecretField.font = Constants.headlineFont
    clientSecretField.layer.borderWidth = 1
    clientSecretField.layer.borderColor = Constants.darkGreyColor.CGColor
    
    if let secret = NSUserDefaults.standardUserDefaults().objectForKey(DefaultsKeys.ClientSecret.rawValue) as? String {
      clientSecretField.text = secret
    } else {
      clientSecretField.text = Constants.clientSecretCashierSample
    }
    
    centerView.addSubview(clientSecretField)
    
    clientSecretField.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(clientSecretLabel.snp_right).offset(20)
      make.top.equalTo(clientSecretLabel)
      make.right.equalTo(-20)
      make.height.equalTo(30)
    }
    
    // uuid
    
    let uuidLabel = UILabel()
    uuidLabel.text = "UUID"
    uuidLabel.font = Constants.headlineFont
    centerView.addSubview(uuidLabel)
    
    uuidLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(20)
      make.top.equalTo(clientSecretLabel.snp_bottom).offset(20)
      make.width.equalTo(100)
      make.height.equalTo(30)
    }
    
    uuidField.font = Constants.headlineFont
    uuidField.layer.borderWidth = 1
    uuidField.layer.borderColor = Constants.darkGreyColor.CGColor
    
    if let uuid = NSUserDefaults.standardUserDefaults().objectForKey(DefaultsKeys.UUID.rawValue) as? String {
      uuidField.text = uuid
    } else {
      uuidField.text = Constants.deviceIdCashierSample
    }
    
    centerView.addSubview(uuidField)
    
    uuidField.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(uuidLabel.snp_right).offset(20)
      make.top.equalTo(uuidLabel)
      make.right.equalTo(-20)
      make.height.equalTo(30)
    }
    
    let okButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    okButton.setTitle("Senden", forState: UIControlState.Normal)
    okButton.addTarget(self, action: "didTapSend", forControlEvents: UIControlEvents.TouchUpInside)
    okButton.backgroundColor = Constants.tintColor
    centerView.addSubview(okButton)
    
    okButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.width.equalTo(100)
      make.height.equalTo(50)
      make.bottom.equalTo(-10)
    }
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
      self.alpha = 1
    })
    
  }
  
  func didTapSend() {
    
    if (checkFields()) {
      
      NSUserDefaults.standardUserDefaults().setObject(clientIdField.text, forKey: DefaultsKeys.ClientId.rawValue)
      NSUserDefaults.standardUserDefaults().setObject(clientSecretField.text, forKey: DefaultsKeys.ClientSecret.rawValue)
      NSUserDefaults.standardUserDefaults().setObject(uuidField.text, forKey: DefaultsKeys.UUID.rawValue)

      delegate?.didSaveCredentials()
      
      hide()
      
    }
    
  }
  
  func checkFields() -> Bool {
    
    clientIdField.layer.borderColor = UIColor.whiteColor().CGColor
    clientSecretField.layer.borderColor = UIColor.whiteColor().CGColor
    uuidField.layer.borderColor = UIColor.whiteColor().CGColor
    
    var valid = true
    
    if clientIdField.text == "" {
      valid = false
      clientIdField.layer.borderColor = Constants.warningColor.CGColor
    }
    
    if clientSecretField.text == "" {
      valid = false
      clientSecretField.layer.borderColor = Constants.warningColor.CGColor
    }
    
    if uuidField.text == "" {
      valid = false
      uuidField.layer.borderColor = Constants.warningColor.CGColor
    }
    
    return valid
    
  }
  
  func hide() {
    
    UIView.animateWithDuration(0.4, animations: { () -> Void in
      
      self.alpha = 0
      
      }) { (done) -> Void in
        
        self.removeFromSuperview()
        
    }
  }
  
}

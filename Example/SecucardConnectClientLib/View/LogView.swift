//
//  LogView.swift
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 11.06.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

import UIKit
import SecucardConnectClientLib

class LogView: UIView {
  
  let logView: UITextView = UITextView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  func setupView() {
    
    backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
    
    let centerView: UIView = UIView()
    centerView.backgroundColor = UIColor.whiteColor()
    addSubview(centerView)
    
    centerView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self).insets(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
      make.centerY.equalTo(self)
    }
    
    var titleLabel: UILabel = UILabel()
    titleLabel.text = "LOG"
    titleLabel.font = UIFont.systemFontOfSize(24)
    centerView.addSubview(titleLabel)
    
    titleLabel.snp_makeConstraints { (make) -> Void in
      make.top.left.equalTo(20)
      make.right.equalTo(-20)
      make.height.equalTo(30)
    }
    
    logView.editable = false
    logView.scrollEnabled = true
    logView.font = Constants.regularFont
    centerView.addSubview(logView)
    
    logView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(centerView).insets(UIEdgeInsets(top: 50, left: 20, bottom: 70, right: 20))
    }
    
    let cancelButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    cancelButton.setTitle("Schließen", forState: UIControlState.Normal)
    cancelButton.addTarget(self, action: "didTapCancel", forControlEvents: UIControlEvents.TouchUpInside)
    cancelButton.backgroundColor = Constants.brightGreyColor
    cancelButton.setTitleColor(Constants.textColor, forState: UIControlState.Normal)
    centerView.addSubview(cancelButton)
    
    cancelButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.width.equalTo(100)
      make.height.equalTo(50)
      make.bottom.equalTo(-10)
    }
    
  }
  
  func addToLog(string: String) {
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      self.logView.text = "\(self.logView.text)\n\n\(string)"
    })
    
  }
  
  func addEventToLog(event: SCGeneralEvent) {
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      
      var eventTypeString = ""
      
      switch event.type.value {
      case EventTypeChanged.value:
        eventTypeString = "changed"
      case EventTypeAdded.value:
        eventTypeString = "added"
      case EventTypeDisplay.value:
        eventTypeString = "display"
      default:
        eventTypeString = "unknown"
      }
      
      if let eventData: AnyObject = event.data {
        self.addToLog("EVENT: \(event.target) | TYPE: \(eventTypeString) | DATA: \(event.data)")
      } else {
        self.addToLog("EVENT: \(event.target) | TYPE: \(eventTypeString)")
      }
      
    })
    
  }
  
  internal func didTapCancel() {
    self.hidden = true
  }
  
}

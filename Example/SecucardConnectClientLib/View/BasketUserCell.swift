//
//  BasketUserCell.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 26.05.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit
import SecucardConnectClientLib

protocol BasketUserCellDelegate {
  func identRemoveTapped()
}

class BasketUserCell: UICollectionViewCell {
  
  var delegate: BasketUserCellDelegate?
  
  var data:SCSmartIdent? {
    
    didSet {
      
      if let data = data {
        
        if let customerForname = data.customer?.contact?.forename {
          label.text = "\(customerForname) \(data.customer.contact.surname)"
        } else if let customerForname = data.customer?.foreName {
          label.text = "\(customerForname) \(data.customer.surName)"
        } else {
          label.text = "\(data.type): \(data.value)"
        }
        
        if let customerPicture = data.customer?.contact?.picture {
          imageView.setImageWithURL(NSURL(string: data.customer.contact.picture), placeholderImage: UIImage(named: "User"))
        } else if let customerPicture = data.customer?.picture {
          imageView.setImageWithURL(NSURL(string: data.customer.picture), placeholderImage: UIImage(named: "User"))
        } else {
          imageView.image = UIImage(named: "User")
        }
        
        if let merchantCard = data.merchantCard {
          lockStatusLabel.text = "Status: \(merchantCard.lockStatus)"
          lastUsedLabel.text = "Zuletzt verw. \(dateFormatter.stringFromDate(merchantCard.lastUsage))"
          pointsLabel.text = "Punkte: \(merchantCard.points)"
          balanceLabel.text = "Guthaben: \(Float(merchantCard.balance)/100) €"
        }
        
      }
    }
  }
  
  let dateFormatter: NSDateFormatter = NSDateFormatter()
  
  var label: UILabel = UILabel()
  var imageView: UIImageView = UIImageView()
  var controls: UIView = UIView()
  
  var lockStatusLabel: UILabel = UILabel()
  var lastUsedLabel: UILabel = UILabel()
  var balanceLabel: UILabel = UILabel()
  var pointsLabel: UILabel = UILabel()
  
  override init(frame: CGRect) {
    
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss";
    
    label.font = Constants.headlineFont
    label.textColor = Constants.textColor
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    
    controls = UIView()
    
    imageView = UIImageView()
    imageView.backgroundColor = Constants.darkGreyColor
    
    lockStatusLabel.font = Constants.regularFont
    lockStatusLabel.textColor = Constants.textColor
    
    lastUsedLabel.font = Constants.regularFont
    lastUsedLabel.textColor = Constants.textColor
    
    balanceLabel.font = Constants.regularFont
    balanceLabel.textColor = Constants.textColor
    
    pointsLabel.font = Constants.regularFont
    pointsLabel.textColor = Constants.textColor
    
    super.init(frame: frame)
    
    self.addSubview(label)
    self.addSubview(controls)
    self.addSubview(imageView)
    
    self.addSubview(lockStatusLabel)
    self.addSubview(lastUsedLabel)
    self.addSubview(balanceLabel)
    self.addSubview(pointsLabel)
    
    imageView.snp_makeConstraints { (make) -> Void in
      make.left.top.equalTo(self)
      make.width.height.equalTo(70)
    }
    
    label.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(imageView.snp_right).offset(10)
      make.right.equalTo(-10)
      make.top.equalTo(self)
      make.height.equalTo(70)
    }
    
    controls.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.height.equalTo(70)
      make.right.equalTo(self).offset(-10)
      make.width.equalTo(50)
    }
    
    lockStatusLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(imageView.snp_bottom).offset(10)
      make.left.equalTo(10)
      make.right.equalTo(-20)
      make.height.equalTo(20)
    }
    
    lastUsedLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(lockStatusLabel.snp_bottom)
      make.left.equalTo(10)
      make.right.equalTo(-20)
      make.height.equalTo(20)
    }
    
    balanceLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(lastUsedLabel.snp_bottom)
      make.left.equalTo(10)
      make.right.equalTo(-20)
      make.height.equalTo(20)
    }
    
    pointsLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(balanceLabel.snp_bottom)
      make.left.equalTo(10)
      make.right.equalTo(-20)
      make.height.equalTo(20)
    }
    
    let removeButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    removeButton.backgroundColor = Constants.warningColor
    removeButton.setImage(UIImage(named: "Trash"), forState: UIControlState.Normal)
    removeButton.addTarget(self, action: Selector("didTapRemove"), forControlEvents: UIControlEvents.TouchUpInside)
    controls.addSubview(removeButton)
    
    removeButton.snp_makeConstraints { (make) -> Void in
      make.left.centerY.equalTo(controls)
      make.width.height.equalTo(50)
    }
    
    
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func didTapRemove() {
    delegate?.identRemoveTapped()
  }
  
  override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes! {
    
    var newFrame: CGRect = layoutAttributes.frame
    newFrame.size.height = 120
    layoutAttributes.frame = newFrame
    
    return layoutAttributes
  }
  
  
  
}

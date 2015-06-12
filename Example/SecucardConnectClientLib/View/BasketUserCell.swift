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
        
        if let customer = data.customer {
          label.text = "\(data.customer.foreName) \(data.customer.surName)"
          imageView.setImageWithURL(NSURL(string: data.customer.picture), placeholderImage: UIImage(named: "User"))
        } else {
          label.text = "\(data.type): \(data.value)"
          imageView.image = UIImage(named: "User")
        }
        
      }
      
    }
  }
  
  var label: UILabel
  var imageView: UIImageView
  var controls: UIView
  
  override init(frame: CGRect) {
    
    label = UILabel()
    label.font = Constants.headlineFont
    label.textColor = Constants.textColor
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    
    controls = UIView()
    
    imageView = UIImageView()
    imageView.backgroundColor = Constants.darkGreyColor
    
    super.init(frame: frame)
    
    self.addSubview(label)
    self.addSubview(controls)
    self.addSubview(imageView)
    
    imageView.snp_makeConstraints { (make) -> Void in
      make.left.top.equalTo(self)
      make.width.height.equalTo(self.snp_height)
    }
    
    label.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(imageView.snp_right).offset(10)
      make.right.equalTo(-10)
      make.top.height.equalTo(self)
    }
    
    controls.snp_makeConstraints { (make) -> Void in
      make.top.height.equalTo(self)
      make.right.equalTo(self).offset(-10)
      make.width.equalTo(50)
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
    //      newFrame.size.height = (theData.expanded) ? 130 : 70
    layoutAttributes.frame = newFrame
    
    return layoutAttributes
  }

  
  
}

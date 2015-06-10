//
//  BasketUserCell.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 26.05.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit
import SecucardConnectClientLib

class BasketUserCell: UICollectionViewCell {

  var data:SCSmartCheckin? {
    
    didSet {
      
      if let data = data {
        
        label.text = data.customerName
        
        if let pictureUrl = data.pictureObject?.url {
          imageView.setImageWithURL(NSURL(string: pictureUrl), placeholderImage: UIImage())
        }
        
      }
      
    }
  }
  
  var imageView: UIImageView
  var label: UILabel
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    
    label = UILabel()
    label.font = Constants.regularFont
    label.textColor = Constants.textColor
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    
    super.init(frame: frame)
    
    self.addSubview(imageView)
    self.addSubview(label)
    
    imageView.snp_makeConstraints { (make) -> Void in
      make.left.top.equalTo(self)
      make.width.height.equalTo(self.snp_height)
    }
    
    label.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(imageView.snp_right).offset(20)
      make.right.equalTo(-10)
      make.top.height.equalTo(self)
    }
    
  }
  
  required init(coder aDecoder: NSCoder) {
    
    imageView = UIImageView()
    label = UILabel()
    
    super.init(coder: aDecoder)
  }

  
}

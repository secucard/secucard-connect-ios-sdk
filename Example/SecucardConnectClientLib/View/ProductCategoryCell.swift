//
//  ProductCategoryCell.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 17.05.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class ProductCategoryCell: UICollectionViewCell {
  
  var data:JSON = nil {
    didSet {
      label.text = self.data["name"].stringValue
      
      label.sizeToFit()
      var f = label.frame
      f.size.height = self.frame.size.height
      f.size.width += 40
      label.frame = f
    }
  }
  
  var imageView: UIImageView
  var label: UILabel
  
  override init(frame: CGRect) {
    
    imageView = UIImageView()
    label = UILabel()
    label.textAlignment = NSTextAlignment.Center
    super.init(frame: frame)
    
    self.addSubview(imageView)
    self.addSubview(label)
  
    
    self.backgroundColor = UIColor.whiteColor()

  }

  required init(coder aDecoder: NSCoder) {
    
    imageView = UIImageView()
    label = UILabel()
    
    super.init(coder: aDecoder)
  }
  
  override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes! {
    
    var attr: UICollectionViewLayoutAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
    
    var newFrame = attr.frame
    self.frame = newFrame
    
    self.setNeedsLayout()
    self.layoutIfNeeded()
    
    newFrame.size.width = self.label.frame.size.width
    attr.frame = newFrame
    return attr
    
  }
  
}

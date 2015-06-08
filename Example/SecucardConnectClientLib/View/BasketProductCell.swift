//
//  BasketProductCell.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 26.05.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol BasketProductCellDelegate {
  
  func removeBasketItem(basketItem:BasketItem)
  func basketItemChanged(basketItem:BasketItem)
  func basketItemLayoutChanged(basketItem:BasketItem)
  
}

class BasketProductCell: UICollectionViewCell, ModifyPriceViewDelegate {

  var data:BasketItem? {
    didSet {
      
      if let theData = data {
        
        // properties
        theData.discount = 1.0
        theData.price = theData.product.price
        
        setLabels()
      }
      
    }
    
  }
  
  // regular controls
  var countLabel: UILabel!
  var nameLabel: UILabel!
  var infoLabel: UILabel!
  var actionsButton : UIButton!
  
  // actions
  var increaseButton : UIButton!
  var decreaseButton : UIButton!
  var changePriceButton : UIButton!
  var addDiscountButton : UIButton!
  var removeButton : UIButton!
  
  var delegate: BasketProductCellDelegate?
  
  override init(frame: CGRect) {
    
    // control initialization
    countLabel = UILabel()
    countLabel.textColor = Constants.textColorBright
    countLabel.font = Constants.regularFont
    countLabel.backgroundColor = Constants.tintColor
    countLabel.textAlignment = NSTextAlignment.Center
    
    nameLabel = UILabel()
    nameLabel.textColor = Constants.textColor
    nameLabel.font = Constants.headlineFont
    
    infoLabel = UILabel()
    infoLabel.textColor = Constants.textColor
    infoLabel.font = Constants.regularFont
    
    actionsButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    actionsButton.setTitle("...", forState: UIControlState.Normal)
    actionsButton.backgroundColor = Constants.brightGreyColor
    
    increaseButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    increaseButton.setTitle("+", forState: UIControlState.Normal)
    increaseButton.backgroundColor = Constants.brightGreyColor
    
    decreaseButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    decreaseButton.setTitle("-", forState: UIControlState.Normal)
    decreaseButton.backgroundColor = Constants.brightGreyColor
    
    changePriceButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    changePriceButton.setTitle("€", forState: UIControlState.Normal)
    changePriceButton.backgroundColor = Constants.brightGreyColor
    
    addDiscountButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    addDiscountButton.setTitle("%", forState: UIControlState.Normal)
    addDiscountButton.backgroundColor = Constants.brightGreyColor
    
    removeButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    removeButton.setTitle("T", forState: UIControlState.Normal)
    removeButton.backgroundColor = Constants.warningColor
    
    var bottomLine: UIView = UIView()
    bottomLine.backgroundColor = Constants.paneBorderColor
    
    // call super
    super.init(frame: frame)
    
    self.clipsToBounds = true
    
    // add items
    self.addSubview(countLabel)
    self.addSubview(nameLabel)
    self.addSubview(infoLabel)
    self.addSubview(actionsButton)
    
    self.addSubview(increaseButton)
    self.addSubview(decreaseButton)
    self.addSubview(changePriceButton)
    self.addSubview(addDiscountButton)
    self.addSubview(removeButton)
    
    self.addSubview(bottomLine)
    
    // layouting
    countLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.top.equalTo(10)
      make.width.height.equalTo(50)
    }
    
    nameLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(countLabel.snp_right).offset(10)
      make.right.equalTo(actionsButton.snp_left).offset(-10)
      make.top.equalTo(countLabel)
      make.bottom.equalTo(countLabel.snp_centerY)
    }
    
    infoLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(countLabel.snp_right).offset(10)
      make.right.equalTo(actionsButton.snp_left).offset(-10)
      make.top.equalTo(countLabel.snp_centerY)
      make.bottom.equalTo(countLabel)
    }
    
    actionsButton.addTarget(self, action: "actionsButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
    actionsButton.snp_makeConstraints { (make) -> Void in
      make.right.equalTo(-10)
      make.top.equalTo(10)
      make.width.height.equalTo(50)
    }
    
    increaseButton.addTarget(self, action: "increaseButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
    increaseButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.top.equalTo(actionsButton.snp_bottom).offset(10)
      make.width.height.equalTo(50)
    }
    
    decreaseButton.addTarget(self, action: "decreaseButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
    decreaseButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(increaseButton.snp_right).offset(10)
      make.top.equalTo(actionsButton.snp_bottom).offset(10)
      make.width.height.equalTo(50)
    }
    
    changePriceButton.addTarget(self, action: "changePriceButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
    changePriceButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(decreaseButton.snp_right).offset(10)
      make.top.equalTo(actionsButton.snp_bottom).offset(10)
      make.width.height.equalTo(50)
    }
    
    addDiscountButton.addTarget(self, action: "addDiscountButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
    addDiscountButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(changePriceButton.snp_right).offset(10)
      make.top.equalTo(actionsButton.snp_bottom).offset(10)
      make.width.height.equalTo(50)
    }
    
    removeButton.addTarget(self, action: "removeButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
    removeButton.snp_makeConstraints { (make) -> Void in
      make.right.equalTo(-10)
      make.top.equalTo(actionsButton.snp_bottom).offset(10)
      make.width.height.equalTo(50)
    }
    
    bottomLine.snp_makeConstraints { (make) -> Void in
      make.left.width.bottom.equalTo(self)
      make.height.equalTo(1)
    }
    
  }
  
  required init(coder aDecoder: NSCoder) {
    
    countLabel = UILabel()
    nameLabel = UILabel()
    infoLabel = UILabel()
    actionsButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    
    super.init(coder: aDecoder)
    
  }
  
  override func prepareForReuse() {
  
    self.data = nil
    self.delegate = nil
    
  }
  
  func setLabels() {
    
    if let theData = data {
    
      countLabel.text = "\(theData.amount)"
      nameLabel.text = theData.product.name
      infoLabel.text = "\(theData.product.articleNumber) - \(theData.price)€"
      if (theData.discount != 1) {
          infoLabel.text = infoLabel.text?.stringByAppendingString(" - \(Int((1-theData.discount)*100))%")
      }
    }
    
  }
  
  func actionsButtonTouched() {
    
    if let theData = data {
      theData.expanded = !theData.expanded
      delegate?.basketItemLayoutChanged(theData)
    }
    
  }
  
  func increaseButtonTouched() {
    
    if let theData = data {
      theData.amount++
      countLabel.text = "\(theData.amount)"
      delegate?.basketItemChanged(theData)
    }
    
  }
  
  func decreaseButtonTouched() {
    
    if let theData = data {
      if (theData.amount > 1) {
        theData.amount--
        countLabel.text = "\(theData.amount)"
        delegate?.basketItemChanged(theData)
      }
    }
    
  }
  
  func changePriceButtonTouched() {
    
    var view: ModifyPriceView = ModifyPriceView(type: PriceChangeType.Price)
    view.delegate = self
    if let window = UIApplication.sharedApplication().keyWindow {
      
      window.addSubview(view)
      view.snp_makeConstraints { (make) -> Void in
        make.edges.equalTo(window)
      }
      
    }
    
  }
  
  func addDiscountButtonTouched() {
    
    var view: ModifyPriceView = ModifyPriceView(type: PriceChangeType.Discount)
    view.delegate = self
    if let window = UIApplication.sharedApplication().keyWindow {
      
      window.addSubview(view)
      view.snp_makeConstraints { (make) -> Void in
        make.edges.equalTo(window)
      }
      
    }
    
  }
  
  func removeButtonTouched() {
    
    if let theDelegate:BasketProductCellDelegate = delegate {
      if let theData = data {
        theDelegate.removeBasketItem(theData)
      }
    }
    
  }
  
  override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes! {
    
    if let theData = data {
      var newFrame: CGRect = layoutAttributes.frame
      newFrame.size.height = (theData.expanded) ? 130 : 70
      layoutAttributes.frame = newFrame
    }
    
    return layoutAttributes
  }
  
  //- Mark
  
  func priceViewChangedPrice(price: Float) {
    if let theData = data {
      theData.price = price
      setLabels()
      delegate?.basketItemChanged(theData)
    }
  }
  
  func priceViewAddedDiscount(discount: Float) {
    if let theData = data {
      theData.discount = 1-(discount/100)
      setLabels()
      delegate?.basketItemChanged(theData)
    }
  }
  
}

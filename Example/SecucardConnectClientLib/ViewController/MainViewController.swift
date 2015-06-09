//
//  MainViewController.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 16.05.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
import SecucardConnectClientLib

enum CollectionType {
  case Product
  case ProductCategories
  case Basket
  case Checkins
  case Unknown
}

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, BasketProductCellDelegate, ScanCardViewDelegate {
  
  let productReuseIdentifier = "ProductCell"
  let categoryReuseIdentifier = "CategoryCell"
  let basketProductReuseIdentifier = "BasketProductCell"
  let basketUserReuseIdentifier = "BasketUserCell"
  let checkinReuseIdentifier = "CheckinCell"
  
  let productCategoriesCollection:UICollectionView
  let productsCollection:UICollectionView
  let basketCollection:UICollectionView
  let checkinsCollection:UICollectionView
  
  var productCategories: [JSON]?
  var basket = [BasketItem]()
  var checkins = [SCSmartCheckin]()
  
  var customerUsed: SCSmartCheckin?
  
  let connectButton: PaymentButton
  let disconnectButton: PaymentButton
  
  let payCashButton: PaymentButton
  let payECButton: PaymentButton
  let paySecucardButton: PaymentButton
  
  let sumLabel: UILabel = UILabel()
  
  var sum: Float = 0.0 {
    didSet {
      sumLabel.text = String(format: "%.2f €", sum)
    }
  }
  
  let emptyButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
  
  var currentCategory = 0 {
    didSet {
      self.productsCollection.reloadData()
      self.productCategoriesCollection.reloadData()
    }
  }
  
  
  var json: JSON = nil {
    didSet {
      if let cats = self.json["groups"].array {
        
        self.productCategories = cats
        self.productCategoriesCollection.reloadData()
        self.productsCollection.reloadData()
        
      }
    }
  }
  
  init() {
    
    self.checkins = [SCSmartCheckin]()
    self.basket = [BasketItem]()
    
    var categoriesLayout = UICollectionViewFlowLayout()
    categoriesLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
    categoriesLayout.minimumInteritemSpacing = 0
    categoriesLayout.estimatedItemSize = CGSizeMake(100, 50)
    
    productCategoriesCollection = UICollectionView(frame: CGRectNull, collectionViewLayout: categoriesLayout)
    productCategoriesCollection.registerClass(ProductCategoryCell.self, forCellWithReuseIdentifier: categoryReuseIdentifier)
    
    
    var productsLayout = UICollectionViewFlowLayout()
    productsLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
    productsLayout.itemSize = CGSizeMake(150, 150)
    
    productsCollection = UICollectionView(frame: CGRectNull, collectionViewLayout: productsLayout)
    productsCollection.registerClass(ProductCell.self, forCellWithReuseIdentifier: productReuseIdentifier)
    productsCollection.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
    
    
    var basketLayout = BasketFlowLayout()
    basketLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
    basketLayout.estimatedItemSize = CGSizeMake(310, 70)
    
    basketCollection = UICollectionView(frame: CGRectNull, collectionViewLayout: basketLayout)
    basketCollection.registerClass(BasketUserCell.self, forCellWithReuseIdentifier: basketUserReuseIdentifier)
    basketCollection.registerClass(BasketProductCell.self, forCellWithReuseIdentifier: basketProductReuseIdentifier)
    
    
    var checkinLayout = UICollectionViewFlowLayout()
    checkinLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
    checkinLayout.itemSize = CGSizeMake(224, 50)
    
    checkinsCollection = UICollectionView(frame: CGRectNull, collectionViewLayout: checkinLayout)
    checkinsCollection.registerClass(CheckinCell.self, forCellWithReuseIdentifier: checkinReuseIdentifier)
    
    // Payment buttons initialization
    connectButton = PaymentButton(title: "connect", action: Selector("didTapConnect"))
    disconnectButton = PaymentButton(title: "disconnect", action: Selector("didTapDisconnect"))
    
    paySecucardButton = PaymentButton(title: "secucard", action: Selector("didTapSecucardButton"))
    payECButton = PaymentButton(title: "EC", action: Selector("didTapECButton"))
    payCashButton = PaymentButton(title: "Bar", action: Selector("didTapCashButton"))
    
    // call super initialization
    super.init(nibName: nil, bundle: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("clientDidDisconnect:"), name: "clientDidDisconnect", object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("clientDidConnect:"), name: "clientDidConnect", object: nil)
    
    // add delegates to collections
    self.productCategoriesCollection.delegate = self
    self.productCategoriesCollection.dataSource = self
    
    self.productsCollection.delegate = self
    self.productsCollection.dataSource = self
    
    self.basketCollection.delegate = self
    self.basketCollection.dataSource = self
    
    self.checkinsCollection.delegate = self
    self.checkinsCollection.dataSource = self
    
    paySecucardButton.target = self
    payECButton.target = self
    payCashButton.target = self
    
    connectButton.target = self
    disconnectButton.target = self
    
    self.connectButton.enabled = true
    self.connectButton.alpha = 1
    self.disconnectButton.enabled = false
    self.disconnectButton.alpha = 0.5
    
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.whiteColor()
    
    // top bar
    let topBar:UIView = UIView()
    topBar.backgroundColor = UIColor.darkGrayColor()
    view.addSubview(topBar)
    
    topBar.snp_makeConstraints { (make) -> Void in
      make.left.top.width.equalTo(view)
      make.height.equalTo(50)
    }
    
    var bottomBar:UIView = UIView()
    bottomBar.backgroundColor = UIColor.whiteColor()
    view.addSubview(bottomBar);
    
    bottomBar.snp_makeConstraints { (make) -> Void in
      make.left.bottom.width.equalTo(view)
      make.height.equalTo(100)
    }
    
    // tabs
    view.addSubview(productCategoriesCollection)
    
    productCategoriesCollection.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.7)
    
    productCategoriesCollection.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(topBar.snp_bottom)
      make.left.equalTo(view)
      make.width.equalTo(490)
      make.height.equalTo(50)
    }
    
    view.addSubview(productsCollection)
    
    productsCollection.backgroundColor = UIColor.whiteColor()
    
    productsCollection.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(view)
      make.bottom.equalTo(bottomBar.snp_top)
      make.top.equalTo(productCategoriesCollection.snp_bottom)
      make.width.equalTo(productCategoriesCollection)
    }
    
    view.addSubview(basketCollection)
    
    basketCollection.backgroundColor = UIColor.whiteColor()
    
    basketCollection.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(topBar.snp_bottom)
      make.left.equalTo(productsCollection.snp_right)
      make.width.equalTo(310)
      make.bottom.equalTo(bottomBar.snp_top).offset(-100)
    }
    
    // sum field
    var sumView: UIView = UIView()
    view.addSubview(sumView)
    sumView.snp_makeConstraints { (make) -> Void in
      make.left.width.equalTo(basketCollection)
      make.bottom.equalTo(bottomBar.snp_top)
      make.height.equalTo(80)
    }
    
    // sum label
    sumLabel.font = Constants.sumFont
    sumView.addSubview(sumLabel)
    
    sumLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(20)
      make.top.height.equalTo(sumView)
      make.width.equalTo(100)
    }
    
    emptyButton.addTarget(self, action: "didTapEmptyButton", forControlEvents: UIControlEvents.TouchUpInside)
    emptyButton.backgroundColor = Constants.tintColor
    sumView.addSubview(emptyButton)
    
    emptyButton.snp_makeConstraints { (make) -> Void in
      make.right.equalTo(-10)
      make.centerY.equalTo(sumView)
      make.width.height.equalTo(50)
    }
    
    var topBorder: UIView = UIView()
    topBorder.backgroundColor = Constants.paneBorderColor
    sumView.addSubview(topBorder)
    topBorder.snp_makeConstraints { (make) -> Void in
      make.left.width.top.equalTo(sumView)
      make.height.equalTo(1)
    }
    
    view.addSubview(checkinsCollection)
    
    checkinsCollection.backgroundColor = UIColor.whiteColor()
    
    checkinsCollection.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(basketCollection.snp_right)
      make.right.equalTo(view)
      make.bottom.equalTo(bottomBar.snp_top)
      make.top.equalTo(topBar.snp_bottom)
    }
    
    // line above bottom bar
    
    let bottomLine:UIView = UIView()
    bottomLine.backgroundColor = UIColor.darkGrayColor()
    view.addSubview(bottomLine)
    
    bottomLine.snp_makeConstraints { (make) -> Void in
      make.left.width.equalTo(view)
      make.bottom.equalTo(bottomBar.snp_top)
      make.height.equalTo(1)
    }
    
    // line between products and basket
    
    let vLine1:UIView = UIView()
    vLine1.backgroundColor = UIColor.darkGrayColor()
    view.addSubview(vLine1)
    
    vLine1.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(basketCollection)
      make.top.equalTo(topBar.snp_bottom)
      make.bottom.equalTo(bottomBar.snp_top)
      make.width.equalTo(1)
    }
    
    // line between basket and checkins
    
    let vLine2:UIView = UIView()
    vLine2.backgroundColor = UIColor.darkGrayColor()
    view.addSubview(vLine2)
    
    vLine2.snp_makeConstraints { (make) -> Void in
      make.right.equalTo(basketCollection)
      make.top.equalTo(topBar.snp_bottom)
      make.bottom.equalTo(bottomBar.snp_top)
      make.width.equalTo(1)
    }
    
    self.view.backgroundColor = UIColor.whiteColor()
    
    // Button: Pay with secucard
    
    bottomBar.addSubview(paySecucardButton)
    
    paySecucardButton.snp_makeConstraints { (make) -> Void in
      make.centerY.equalTo(bottomBar)
      make.right.equalTo(-20)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
    
    // Button: Pay by Debitcard
    
    bottomBar.addSubview(payECButton)
    
    payECButton.snp_makeConstraints { (make) -> Void in
      make.centerY.equalTo(bottomBar)
      make.right.equalTo(paySecucardButton.snp_left).offset(-20)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
    
    // Button: Pay Cash
    
    bottomBar.addSubview(payCashButton)
    
    payCashButton.snp_makeConstraints { (make) -> Void in
      make.centerY.equalTo(bottomBar)
      make.right.equalTo(payECButton.snp_left).offset(-20)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
    
    // connect button
    
    bottomBar.addSubview(connectButton)
    
    connectButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(20)
      make.centerY.equalTo(bottomBar)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
    
    // disconnect button
    
    bottomBar.addSubview(disconnectButton)
    
    disconnectButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(connectButton.snp_right).offset(20)
      make.centerY.equalTo(bottomBar)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
    
    calcPrice()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func identifierForCollection(collection: UICollectionView) -> CollectionType {
    if collection == productCategoriesCollection {
      return CollectionType.ProductCategories
    } else if collection == productsCollection {
      return CollectionType.Product
    } else if collection == basketCollection {
      return CollectionType.Basket
    } else if collection == checkinsCollection {
      return CollectionType.Checkins
    } else {
      return CollectionType.Unknown
    }
  }
  
  func calcPrice() {
    sum = 0.0
    for bi:BasketItem in basket {
      if (bi.type == BasketItemType.Product) {
        let newVal = sum + (bi.price * bi.discount * Float(bi.amount))
        sum = newVal
      }
    }
  }
  
  func didTapEmptyButton() {
    
    sum = 0.0
    basket = [BasketItem]()
    
  }
  
  // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    
    switch identifierForCollection(collectionView) {
      
    case CollectionType.Product:
      return 2
      
    default:
      return 1
      
    }
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    switch identifierForCollection(collectionView) {
      
    case CollectionType.ProductCategories:
      
      if let numCategories = productCategories?.count {
        return numCategories
      } else {
        return 0
      }
      
    case CollectionType.Product:
      
      if (section == 0) {
        
        if let items:[JSON] = json["groups"][currentCategory]["items"].array {
          return items.count
        } else {
          return 0
        }
        
      } else {
        
        if let usedCustomer = customerUsed {
          return 1
        } else {
          return 0
        }
        
      }
      
      
    case CollectionType.Basket:
      
      return basket.count
      
    case CollectionType.Checkins:
      
      return checkins.count
      
    default:
      return 0
      
    }
    
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    switch identifierForCollection(collectionView) {
      
    case CollectionType.ProductCategories:
      
      if let categories = productCategories {
        
        var cell:ProductCategoryCell = collectionView.dequeueReusableCellWithReuseIdentifier(categoryReuseIdentifier, forIndexPath: indexPath) as! ProductCategoryCell
        cell.data = categories[indexPath.row]
        cell.backgroundColor = (indexPath.row == currentCategory) ? UIColor.whiteColor() : UIColor.lightGrayColor().colorWithAlphaComponent(0.2)
        
        return cell
        
      }
      
    case CollectionType.Product:
      
      if let items:[JSON] = json["groups"][currentCategory]["items"].array {
        
        if let cell:ProductCell = collectionView.dequeueReusableCellWithReuseIdentifier(productReuseIdentifier, forIndexPath: indexPath) as? ProductCell {
          cell.data = Product(product: items[indexPath.row])
          return cell
        }
        
      }
      
    case CollectionType.Basket:
      
      let item:BasketItem = basket[indexPath.row]
      
      switch item.type! {
        
      case BasketItemType.Checkin:
        
        if let cell:BasketUserCell = collectionView.dequeueReusableCellWithReuseIdentifier(basketUserReuseIdentifier, forIndexPath: indexPath) as? BasketUserCell {
          cell.data = item
          return cell
        }
        
      case BasketItemType.Product:
        
        if let cell:BasketProductCell = collectionView.dequeueReusableCellWithReuseIdentifier(basketProductReuseIdentifier, forIndexPath: indexPath) as? BasketProductCell {
          cell.delegate = self
          cell.data = item
          return cell
        }
        
      default:
        
        return UICollectionViewCell()
        
      }
      
    case CollectionType.Checkins:
      
      let checkin:SCSmartCheckin = checkins[indexPath.row]
      
      if let cell:CheckinCell = collectionView.dequeueReusableCellWithReuseIdentifier(checkinReuseIdentifier, forIndexPath: indexPath) as? CheckinCell {
        cell.data = checkin
        return cell
      }
      
    default:
      
      return UICollectionViewCell()
      
    }
    
    return UICollectionViewCell()
    
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    switch identifierForCollection(collectionView) {
      
    case CollectionType.ProductCategories:
      
      currentCategory = indexPath.row
      
    case CollectionType.Product:
      
      if let items:[JSON] = json["groups"][currentCategory]["items"].array {
        
        var item:JSON = items[indexPath.row]
        let basketItem: BasketItem = BasketItem(product: Product(product: item))
        
        basket.append(basketItem)
        basketCollection.reloadData()
        
        calcPrice()
        
      }
      
    case CollectionType.Checkins:
      
      NSLog(checkins[indexPath.row].customerName)
      
    default:
      
      return
      
    }
  }
  
  
  // MARK: - ModifyPriceViewDelegate
  
  func removeBasketItem(basketItem: BasketItem) {
    
    for (index:Int, basketItemTest:BasketItem) in enumerate(basket) {
      if (basketItem == basketItemTest) {
        basket.removeAtIndex(index)
        basketCollection.reloadData()
        calcPrice()
        return
      }
    }
    
  }
  
  func basketItemLayoutChanged(basketItem: BasketItem) {
    basketCollection.collectionViewLayout.invalidateLayout()
  }
  
  func basketItemChanged(basketItem: BasketItem) {
    calcPrice()
  }
  
  // MARK: - Payment actions
  
  // payment actions
  
  func didTapSecucardButton() {
    
    if let usedCustomer = customerUsed {
      
      // user did select checked in customer
      
    } else {
      
      // user did not select any customer -> scan card
      let view = ScanCardView()
      view.delegate = self
      
      if let window = UIApplication.sharedApplication().keyWindow {
        window.addSubview(view)
        view.snp_makeConstraints { (make) -> Void in
          make.edges.equalTo(window)
        }
      }
      
    }
    
  }
  
  func didTapECButton() {
    
  }
  
  func didTapCashButton() {
    
  }
  
  func didTapConnect() {
    
    if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
      appDelegate.connectCashier({ (success: Bool, error: NSError?) -> Void in
      })
    }
  }
  
  func didTapDisconnect() {
    SCConnectClient.sharedInstance().disconnect { (success: Bool, error: NSError!) -> Void in
      if (success) {
        NSNotificationCenter.defaultCenter().postNotificationName("clientDidDisconnect", object: nil)
      }
    }
  }
  
  func clientDidDisconnect(notification : NSNotification) {
    connectButton.enabled = true
    connectButton.alpha = 1
    disconnectButton.enabled = false
    disconnectButton.alpha = 0.5
  }
  
  func clientDidConnect(notification : NSNotification) {
    disconnectButton.enabled = true
    disconnectButton.alpha = 1
    connectButton.enabled = false
    connectButton.alpha = 0.5
  }
  
  // MARK: - ScanCardViewDelegate
  
  func scanCardFinished(code: String) {
    
  }
  
}

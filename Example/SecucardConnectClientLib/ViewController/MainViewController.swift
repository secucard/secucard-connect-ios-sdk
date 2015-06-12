//
//  MainViewController.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 16.05.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import Foundation
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

enum PayMethod : String {
  case Unset = "unset"
  case Demo = "demo"
  case Cash = "cash"
  case Auto = "auto"
  case Cashless = "cashless"
  case Loyalty = "loyalty"
  case Paypal = "paypal"
}

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, BasketProductCellDelegate, ScanViewControllerDelegate, BasketUserCellDelegate {
  
  let productReuseIdentifier = "ProductCell"
  let categoryReuseIdentifier = "CategoryCell"
  let basketProductReuseIdentifier = "BasketProductCell"
  let basketUserReuseIdentifier = "BasketUserCell"
  let checkinReuseIdentifier = "CheckinCell"
  
  let basketSectionHeaerReuseIdentifier = "HeaderView"
  
  let productCategoriesCollection:UICollectionView
  let productsCollection:UICollectionView
  let basketCollection:UICollectionView
  let checkinsCollection:UICollectionView
  
  var productCategories: [JSON]?
  var checkins = [SCSmartCheckin]() {
    didSet {
      checkinsCollection.reloadData()
    }
  }
  
  var basket = [BasketItem]() {
    didSet {
      CheckTransactionReady()
      basketCollection.reloadData()
      calcPrice()
      updateTransactionBasket()
    }
  }
  
  var customerUsed: SCSmartIdent? {
    didSet {
      CheckTransactionReady()
      basketCollection.reloadData()
    }
  }
  
  let connectButton: PaymentButton
  let disconnectButton: PaymentButton
  let scanCardButton: PaymentButton
  let showLogButton: PaymentButton
  
  let payAutoButton = PaymentButton(payMethod: PayMethod.Auto, action: Selector("didTapPayButton:"))
  let payDemoButton = PaymentButton(payMethod: PayMethod.Demo, action: Selector("didTapPayButton:"))
  let payPaypalButton = PaymentButton(payMethod: PayMethod.Paypal, action: Selector("didTapPayButton:"))
  let payLoyaltyButton = PaymentButton(payMethod: PayMethod.Loyalty, action: Selector("didTapPayButton:"))
  let payCashlessButton = PaymentButton(payMethod: PayMethod.Cashless, action: Selector("didTapPayButton:"))
  let payCashButton = PaymentButton(payMethod: PayMethod.Cash, action: Selector("didTapPayButton:"))
  
  let availableButtons: [PaymentButton]
  
  let logView: LogView = LogView()
  
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
  
  var currentTransaction: SCSmartTransaction = SCSmartTransaction()
  
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
    basketLayout.headerReferenceSize = CGSizeMake(310, 30)
    
    basketCollection = UICollectionView(frame: CGRectNull, collectionViewLayout: basketLayout)
    basketCollection.registerClass(CheckinCell.self, forCellWithReuseIdentifier: checkinReuseIdentifier)
    basketCollection.registerClass(BasketUserCell.self, forCellWithReuseIdentifier: basketUserReuseIdentifier)
    basketCollection.registerClass(BasketProductCell.self, forCellWithReuseIdentifier: basketProductReuseIdentifier)
    basketCollection.registerClass(SectionheaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: basketSectionHeaerReuseIdentifier)
    
    var checkinLayout = UICollectionViewFlowLayout()
    checkinLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
    checkinLayout.itemSize = CGSizeMake(224, 50)
    
    checkinsCollection = UICollectionView(frame: CGRectNull, collectionViewLayout: checkinLayout)
    checkinsCollection.registerClass(CheckinCell.self, forCellWithReuseIdentifier: checkinReuseIdentifier)
    
    // Payment buttons initialization
    connectButton = PaymentButton(icon: "Connect", action: Selector("didTapConnect"))
    disconnectButton = PaymentButton(icon: "Disconnect", action: Selector("didTapDisconnect"))
    scanCardButton = PaymentButton(icon: "ScanCard", action: Selector("didTapScanCard"))
    showLogButton = PaymentButton(icon: "Log", action: Selector("didTapShowLog"))
    
    availableButtons = [payDemoButton, payPaypalButton, payLoyaltyButton, payCashlessButton, payAutoButton, payCashButton]
    
    // call super initialization
    super.init(nibName: nil, bundle: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("clientDidDisconnect:"), name: "clientDidDisconnect", object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("clientDidConnect:"), name: "clientDidConnect", object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didReceiveStompResult:"), name: "notificationStompResult", object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didReceiveStompError:"), name: "notificationStompError", object: nil)
    
    // add delegates to collections
    self.productCategoriesCollection.delegate = self
    self.productCategoriesCollection.dataSource = self
    
    self.productsCollection.delegate = self
    self.productsCollection.dataSource = self
    
    self.basketCollection.delegate = self
    self.basketCollection.dataSource = self
    
    self.checkinsCollection.delegate = self
    self.checkinsCollection.dataSource = self
    
    payAutoButton.target = self
    payCashlessButton.target = self
    payCashButton.target = self
    payLoyaltyButton.target = self
    payPaypalButton.target = self
    payDemoButton.target = self
    
    connectButton.target = self
    disconnectButton.target = self
    scanCardButton.target = self
    showLogButton.target = self
    
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
    topBar.backgroundColor = Constants.darkGreyColor
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
    
    productCategoriesCollection.backgroundColor = UIColor.darkGrayColor()
    
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
    
    let checkinHeader = UILabel()
    checkinHeader.text = "   Check-ins"
    checkinHeader.textColor = Constants.textColorBright
    checkinHeader.backgroundColor = Constants.darkGreyColor
    
    view.addSubview(checkinHeader)
    
    checkinHeader.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(topBar.snp_bottom)
      make.left.equalTo(productCategoriesCollection.snp_right)
      make.width.equalTo(224)
      make.height.equalTo(50)
    }
    
    view.addSubview(checkinsCollection)
    
    checkinsCollection.backgroundColor = UIColor.whiteColor()
    
    checkinsCollection.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(productsCollection.snp_right)
      make.top.equalTo(checkinHeader.snp_bottom)
      make.width.equalTo(224)
      make.bottom.equalTo(bottomBar.snp_top)
    }
    
    let basketHeader = UILabel()
    basketHeader.text = "   Warenkorb"
    basketHeader.textColor = Constants.textColorBright
    basketHeader.backgroundColor = Constants.darkGreyColor
    
    view.addSubview(basketHeader)
    
    basketHeader.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(topBar.snp_bottom)
      make.left.equalTo(checkinHeader.snp_right)
      make.right.equalTo(view)
      make.height.equalTo(50)
    }

    view.addSubview(basketCollection)
    
    basketCollection.backgroundColor = UIColor.whiteColor()
    
    basketCollection.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(bottomBar.snp_top).offset(-80)
      make.top.equalTo(basketHeader.snp_bottom)
      make.left.equalTo(checkinsCollection.snp_right)
      make.right.equalTo(view)
    }
    
    // sum field
    var sumView: UIView = UIView()
    sumView.backgroundColor = Constants.brightGreyColor
    
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
    
    emptyButton.setImage(UIImage(named: "Trash"), forState: UIControlState.Normal)
    emptyButton.addTarget(self, action: "didTapEmptyButton", forControlEvents: UIControlEvents.TouchUpInside)
    emptyButton.backgroundColor = Constants.warningColor
    sumView.addSubview(emptyButton)
    
    emptyButton.snp_makeConstraints { (make) -> Void in
      make.right.equalTo(-10)
      make.centerY.equalTo(sumView)
      make.width.height.equalTo(50)
    }
    
    var topBorder: UIView = UIView()
    topBorder.backgroundColor = Constants.brightGreyColor
    sumView.addSubview(topBorder)
    topBorder.snp_makeConstraints { (make) -> Void in
      make.left.width.top.equalTo(sumView)
      make.height.equalTo(1)
    }
    // line above bottom bar
    
    let bottomLine:UIView = UIView()
    bottomLine.backgroundColor = Constants.brightGreyColor
    view.addSubview(bottomLine)
    
    bottomLine.snp_makeConstraints { (make) -> Void in
      make.left.width.equalTo(view)
      make.bottom.equalTo(bottomBar.snp_top)
      make.height.equalTo(1)
    }
    
    // line between products and basket
    
    let vLine1:UIView = UIView()
    vLine1.backgroundColor = Constants.brightGreyColor
    view.addSubview(vLine1)
    
    vLine1.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(checkinsCollection)
      make.top.equalTo(topBar.snp_bottom)
      make.bottom.equalTo(bottomBar.snp_top)
      make.width.equalTo(1)
    }
    
    // line between basket and checkins
    
    let vLine2:UIView = UIView()
    vLine2.backgroundColor = Constants.brightGreyColor
    view.addSubview(vLine2)
    
    vLine2.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(basketCollection)
      make.top.equalTo(topBar.snp_bottom)
      make.bottom.equalTo(bottomBar.snp_top)
      make.width.equalTo(1)
    }
    
    self.view.backgroundColor = UIColor.whiteColor()
    
    // Button: Pay with secucard
    
    var lastButton: PaymentButton?
    for button in availableButtons {
      
      bottomBar.addSubview(button)
      
      button.snp_makeConstraints { (make) -> Void in
        if let lastButton = lastButton {
          make.right.equalTo(lastButton.snp_left).offset(-10)
        } else {
          make.right.equalTo(-10)
        }
        
        make.centerY.equalTo(bottomBar)
        make.width.equalTo(100)
        make.height.equalTo(50)
      }
      
      lastButton = button
      
    }
    
    // connect button
    
    bottomBar.addSubview(connectButton)
    
    connectButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.centerY.equalTo(bottomBar)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
    
    // disconnect button
    
    bottomBar.addSubview(disconnectButton)
    
    disconnectButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(connectButton.snp_right).offset(10)
      make.centerY.equalTo(bottomBar)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
    
    // scan card button
    
    bottomBar.addSubview(scanCardButton)
    
    scanCardButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(disconnectButton.snp_right).offset(10)
      make.centerY.equalTo(bottomBar)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
    
    // show log button
    
    bottomBar.addSubview(showLogButton)
    
    showLogButton.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(scanCardButton.snp_right).offset(10)
      make.centerY.equalTo(bottomBar)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
    
    // log view
    
    view.addSubview(logView)
    
    logView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(view)
    }
    
    logView.hidden = true
    
    calcPrice()
    CheckTransactionReady()
      
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
      
    case CollectionType.Basket:
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
      
      if let items:[JSON] = json["groups"][currentCategory]["items"].array {
        return items.count
      } else {
        return 0
      }
      
    case CollectionType.Basket:
      
      if (section == 0) {
        
        return basket.count
        
      } else {
        
        if let usedCustomer = customerUsed {
          return 1
        } else {
          return 0
        }
        
      }
      
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
        cell.backgroundColor = (indexPath.row == currentCategory) ? UIColor.whiteColor() : Constants.brightGreyColor
        
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
      
      if (indexPath.section == 0) {
        
        let item:BasketItem = basket[indexPath.row]
        
        if let cell:BasketProductCell = collectionView.dequeueReusableCellWithReuseIdentifier(basketProductReuseIdentifier, forIndexPath: indexPath) as? BasketProductCell {
          cell.delegate = self
          cell.data = item
          return cell
        }
        
      } else {
        
        if let cell:BasketUserCell = collectionView.dequeueReusableCellWithReuseIdentifier(basketUserReuseIdentifier, forIndexPath: indexPath) as? BasketUserCell {
          cell.data = customerUsed
          cell.delegate = self
          return cell
        }
        
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
        calcPrice()
        
      }
      
    case CollectionType.Checkins:
      
      let checkin = checkins[indexPath.row]
      
      let ident = SCSmartIdent()
      ident.type = "checkin"
      ident.value = checkin.id
      
      customerUsed = ident
      updateTransactionIdent()
      
    default:
      
      return
      
    }
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
    if collectionView == basketCollection {
      
      if (kind == UICollectionElementKindSectionHeader) {
        
        let headerView: SectionheaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: basketSectionHeaerReuseIdentifier, forIndexPath: indexPath) as! SectionheaderView
        
        headerView.label.text = (indexPath.section == 0) ? "Produkte" : "Käufer"
        
        return headerView
        
      }
      
    }
    
    return SectionheaderView()
    
  }
  
  
  
  // MARK: - ModifyPriceViewDelegate
  
  func removeBasketItem(basketItem: BasketItem) {
    
    for (index:Int, basketItemTest:BasketItem) in enumerate(basket) {
      if (basketItem == basketItemTest) {
        basket.removeAtIndex(index)
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

  func didTapPayButton(button: PaymentButton) {
    if let usedCustomer = customerUsed {
      sendTransaction(button.payMethod)
    } else {
      showScanCardView()
    }
  }

  func showScanCardView() {

    var view: ScanViewController = ScanViewController()
    view.delegate = self;
    self.presentViewController(view, animated: true, completion: nil)
    
  }
  
  func updateTransactionBasket() {
    
    // create a basket
    let basket = SCSmartBasket()
    
    var productList = [AnyObject]()
    for basketItem:BasketItem in self.basket {
      if let productData = basketItem.product.data {
        //productList.append(productData.dictionaryObject!)
        //productList.append(productData.stringValue)
      }
    }
    
    basket.products = productList
    
    currentTransaction.basket = basket
    
    // create a basket info
    
    let basketInfo = SCSmartBasketInfo()
    basketInfo.sum = Int(sum*100)
    basketInfo.currency = "EUR"
    currentTransaction.basketInfo = basketInfo
    
    saveTransaction({ (success, error) -> Void in
      if let error = error {
        ErrorManager.handleError(error)
      }
    })
    
  }
  
  func updateTransactionIdent() {
    
    // create the ident
    if let ident = customerUsed {
      currentTransaction.idents = [ident]
      saveTransaction({ (success, error) -> Void in
        
        if let error = error {
          ErrorManager.handleError(error)
        }
        
        if let resolvedIdent = self.currentTransaction.idents[0] as? SCSmartIdent {
          
          dispatch_async(dispatch_get_main_queue(), { () -> Void in

            if !resolvedIdent.valid {
              ErrorManager.handleError(ErrorManager.errorWithDescription("Identifizierung fehlgeschlagen"))
              self.customerUsed = nil
            } else {
              self.customerUsed = resolvedIdent
            }
          
          })
        }
        
      })
    }
    
  }
  
  func saveTransaction(handler: (success: Bool,error: NSError?) -> Void) {
    
    currentTransaction.merchantRef = Constants.merchantRef
    currentTransaction.transactionRef = "\(Constants.merchantRef)_\(NSDate().timeIntervalSince1970)"
    
    if currentTransaction.id == nil {
      SCSmartTransactionService.sharedService().createTransaction(currentTransaction, completionHandler: { (createdTransaction: SCSmartTransaction?, error: NSError?) -> Void in
        
        if let createdTransaction = createdTransaction {
          self.currentTransaction = createdTransaction
        }
        
        handler(success: createdTransaction != nil, error: error)
        
      })
    } else {
      
      SCSmartTransactionService.sharedService().updateTransaction(currentTransaction, completionHandler: { (updatedTransaction: SCSmartTransaction?, error: NSError?) -> Void in
        
        if let updatedTransaction = updatedTransaction {
          self.currentTransaction = updatedTransaction
        }
        
        handler(success: updatedTransaction != nil, error: error)
        
      })
      
    }
    
  }
  
  func sendTransaction(method: PayMethod) {
    
    // if not created yet, create it and try again
    if currentTransaction.id == nil {
      saveTransaction({ (success, error) -> Void in
        if success {
          self.sendTransaction(method)
        }
      })
      return
    }
    
    let statusView = TransactionStatusView();
    view.addSubview(statusView)
    
    statusView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(view)
    }
    
    statusView.addStatus("Transaktion wird durchgeführt")
    
    // start
    SCSmartTransactionService.sharedService().startTransaction(currentTransaction.id, type: method.rawValue, completionHandler: { (transactionResult: SCSmartTransaction?, error: NSError?) -> Void in
      
      if let error = error {
        
        self.logView.addToLog("ERROR: \(error.localizedDescription)");
        statusView.addStatus("Transaktionsabbruch: \(error.localizedDescription)")
        
      } else {
        
        if let result = transactionResult {
          
          self.logView.addToLog("SUCCESS");
          
          // check results
          if result.status == "ok" {
            statusView.addStatus("Transaktion erfolgreich durchgeführt\n\nStatus:\n\n")
          } else if result.status == "failed" {
            statusView.addStatus("Transaktion konnte nicht erfolgreich durchgeführt werden")
          }
          
          if let receiptLines = result.receiptLines as? [SCSmartReceiptLine] {
            
            for line in receiptLines {
              
              if line.type == "space" {
                
                statusView.addStatus("\n")
                
              } else if line.type == "textline" {
                
                statusView.addStatus("\(line.value)")
                
              }
            }
          }
        }
      }
    })
  }
  
  func CheckTransactionReady() {
    
    let ready = (basket.count > 0)
    
    for button in availableButtons {
      button.enabled = ready
      button.alpha = ready ? 1 : 0.5
    }
    
  }
  
  func didTapScanCard() {
    showScanCardView()
  }
  
  func didTapShowLog() {
    logView.hidden = false
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
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      
      self.connectButton.enabled = true
      self.connectButton.alpha = 1
      self.disconnectButton.enabled = false
      self.disconnectButton.alpha = 0.5
      
    })
    
  }
  
  func clientDidConnect(notification : NSNotification) {
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
    
      self.disconnectButton.enabled = true
      self.disconnectButton.alpha = 1
      self.connectButton.enabled = false
      self.connectButton.alpha = 0.5
      
    })
    
  }
  
  func identRemoveTapped() {

    customerUsed = nil
    updateTransactionIdent()
    
  }
  
  func scanViewReturnCode(code: String) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
   
    let ident = SCSmartIdent()
    ident.type = "card"
    ident.value = code
    
    customerUsed = ident
    updateTransactionIdent()

  }
  
  // MARK: - Notification handlers
  
  func didReceiveStompResult(notification: NSNotification) {
    if let message = notification.userInfo?["message"] as? String {
      logView.addToLog(message)
    }
  }
  
  func didReceiveStompError(notification: NSNotification) {
    if let message = notification.userInfo?["message"] as? String {
      logView.addToLog(message)
    }
  }
  
}

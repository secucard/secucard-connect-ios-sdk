//
//  Constants.swift
//  CashierApp
//
//  Created by Jörn Schmidt on 02.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

import UIKit

class Constants: NSObject {
  
  // API Settings
  static let baseUrl: String = "https://connect.secucard.com/api/v2/"
  static let authUrl: String = "https://connect.secucard.com/"
  
  static let stompHost: String = "connect.secucard.com"
  static let stompVHost: String = "/"
  static let stompPort: Int32 = 61614
  static let replyQueue: String = "/temp-queue/main"
  static let connectionTimeoutSec: Int32 =   30
  static let socketTimeoutSec: Int32 =   30
  static let heartbeatMs: Int32 =   40000
  static let basicDestination: String = "/exchange/connect.api/"
  
  static let usernameAppSample: String = "checkoutsecucard"
  static let passwordAppSample: String = "checkout"
  static let clientIdAppSample: String = "app.mobile.secucard"
  static let clientSecretAppSample: String = "dc1f422dde755f0b1c4ac04e7efbd6c4c78870691fe783266d7d6c89439925eb"
  static let deviceIdAppSample: String = "611c00ec6b2be6c77c2338774f50040b"
  
  static let usernameCashierSample: String = "secucard.dresden"
  static let passwordCashierSample: String = "Kasse12345"
  static let clientIdCashierSample: String = "611c00ec6b2be6c77c2338774f50040b"
  static let clientSecretCashierSample: String = "dc1f422dde755f0b1c4ac04e7efbd6c4c78870691fe783266d7d6c89439925eb"
  static let deviceIdCashierSample: String = "/vendor/vendor_name/cashier/iostest1"
  //static let UUIDCashierSample: String = "/vendor/unknown/cashier/iostest1"
  
  static let contactForename: String = "DeviD"
  static let contactSurname: String = "Testermann"
  static let contactSalutation: String = "Herr"
  static let contactEmail: String = "schmidt@devid.net"
  
  static let accountUsername: String = "schmidtdevid.net"
  static let acccountPassword: String = "Secucard123"
  
  // Colors
  static let tintColor: UIColor = UIColor(red: 51/255, green: 128/255, blue: 255/255, alpha: 1)
  static let tintColorBright: UIColor = UIColor(red: 51/255, green: 128/255, blue: 255/255, alpha: 1)
  static let textColor: UIColor = UIColor.darkGrayColor()
  static let textColorBright: UIColor = UIColor.whiteColor()
  static let paneBgColor: UIColor = UIColor.whiteColor()
  static let paneBorderColor: UIColor = UIColor.lightGrayColor()
  static let brightGreyColor: UIColor = UIColor.lightGrayColor()
  static let warningColor: UIColor = UIColor.orangeColor()
  
  // Fontsizes
  static let regularFont: UIFont = UIFont.systemFontOfSize(12.0)
  static let headlineFont: UIFont = UIFont.systemFontOfSize(16.0)
  static let sumFont: UIFont = UIFont.systemFontOfSize(18.0)
  
}

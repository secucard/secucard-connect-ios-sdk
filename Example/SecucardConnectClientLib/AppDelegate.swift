  //
  //  AppDelegate.swift
  //  Sample
  //
  //  Created by Jörn Schmidt on 16.05.15.
  //  Copyright (c) 2015 devid. All rights reserved.
  //
  
  import Foundation
  import UIKit
  import SecucardConnectClientLib
  import SwiftyJSON
  
  @UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var products: JSON?
    var mainController: MainViewController!
    var connectClient: SCConnectClient?
    var verificationView: InsertCodeView?
    var pollingTimer: NSTimer?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "showDeviceAuthInformation:", name: "deviceAuthCodeRequesting", object: nil)
      
      // read data
      if let path = NSBundle.mainBundle().pathForResource("products", ofType: "json") {
        if let data = NSData(contentsOfFile: path) {
          products = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
          // print out data
          //        println("jsonData:\(products)")
          //        println("error\(products?.error)")
        }
      }
      
      // initialize view
      mainController = MainViewController()
      
      // with parsed data if avaliable
      if let parsedProducts = products {
        mainController.json = parsedProducts
      }
      
      connectCashier { (success: Bool, error: NSError?) -> Void in
        
      }
      
      // show window and initial view controller
      window = UIWindow(frame: UIScreen.mainScreen().bounds)
      window?.rootViewController = self.mainController
      window?.makeKeyAndVisible()
      
      return true
    }
    
    func connectCashier( handler: (success: Bool, error: NSError?) -> Void ) -> Void {
      
      // initialize connect client
      
      let restConfig: SCRestConfiguration = SCRestConfiguration(baseUrl: Constants.baseUrl, andAuthUrl: Constants.authUrl)
      
      let stompConfig: SCStompConfiguration = SCStompConfiguration(host: Constants.stompHost, andVHost: Constants.stompVHost, port: Constants.stompPort, userId: "", password: "", useSSL: true, replyQueue: Constants.replyQueue, connectionTimeoutSec: Constants.connectionTimeoutSec, socketTimeoutSec: Constants.socketTimeoutSec, heartbeatMs: Constants.heartbeatMs, basicDestination: Constants.basicDestination)
      
      let clientCredentials: SCClientCredentials = SCClientCredentials(clientId: Constants.clientIdCashierSample, clientSecret: Constants.clientSecretCashierSample)
      
      let clientConfig: SCClientConfiguration = SCClientConfiguration(restConfiguration: restConfig, stompConfiguration: stompConfig, defaultChannel: OnDemandChannel, stompEnabled: true, oauthUrl: Constants.authUrl, clientCredentials: clientCredentials, userCredentials: SCUserCredentials(), deviceId: Constants.deviceIdCashierSample, authType: "device")
      
      // TEMP: add to always call device auth
      // SCAccountManager.sharedManager().killToken()
      
      // connect to server and try to login
      if let client = SCConnectClient.sharedInstance() {
        
        client.initWithConfiguration(clientConfig)
        
        client.connect({ (success: Bool, error: NSError?) -> Void in
          
          let s: Bool = success
          
          if let error = error {
            ErrorManager.handleError(error)
            handler(success: false, error: error)
          }
          
          if success {
            
            // close verification view
            if let vView = self.verificationView {
              dispatch_async(dispatch_get_main_queue(), { () -> Void in
                vView.hide()
              })
            }
            
            dispatch_async(dispatch_get_main_queue(), {
              if let timerValid = self.pollingTimer?.valid {
                self.pollingTimer?.invalidate()
              }
              self.pollingTimer = NSTimer.scheduledTimerWithTimeInterval(1000, target: self, selector: Selector("pollCheckins"), userInfo: nil, repeats: true)
              self.pollingTimer?.fire()
            })

            NSNotificationCenter.defaultCenter().postNotificationName("clientDidConnect", object: nil)
            
            handler(success: true, error: nil)
          } else {
            handler(success: false, error: nil)
          }
          
        })
        
      }
      
    }
    
    func pollCheckins() {
      
      // check for checkins
      SCCheckinService.sharedService().getCheckins({ ( result: [AnyObject]?, error: NSError?) -> Void in
        
        if let error = error {
          
          print("couldn't get checkins because: \(error.localizedDescription)")
          
        } else if let checkins = result as? [SCSmartCheckin] {
          
          self.mainController.checkins = checkins
          dispatch_async(dispatch_get_main_queue(), {
            self.mainController.checkinsCollection.reloadData()
          })
          
        }
        
      });
      
    }
    
    func showDeviceAuthInformation(notification : NSNotification) {
      
      if let info = notification.userInfo {
        
        if let code: SCAuthDeviceAuthCode = info["code"] as? SCAuthDeviceAuthCode {
          
          if let w = window {
            
            verificationView = InsertCodeView(authCode: code)
            
            if let verificationView = verificationView {
              
              w.addSubview(verificationView)
              
              verificationView.snp_makeConstraints { (make) -> Void in
                make.edges.equalTo(w)
              }
              
            }
            
          }
          
        }
        
      }
      
    }
    
    func applicationWillResignActive(application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
      // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
  }
  

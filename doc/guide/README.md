# secucard connect iOS SDK Guide


SDK for using the [secuconnect API](http://developer.secuconnect.com/) on iOS.

## Requirements

iOS 8.0+  
Xcode 7.2+

## Install

Currently we offer the SecucardConnectSDK to be installed via Cocoapods only. It is available [here](http://cocoapods.org/). To install it, simply add the following line to your Podfile:

```ruby
pod "SecucardConnectSDK"
```

## Usage

There are generally two ways to set up the SDK for your needs. Right now only the instantiation of several configuration objects is necessary. In the near future we will provide a config plist to enter your configuration aside from code.

### Client Configruation

Since there are two ways of communication, you will need to enter the appropriate configuration for both. REST ist referred to as the On-Demand-Channel as it opens and closes the communication channel for each request. STOMP is used as persistent channel.

**REST-Channel-Config (On-Demand)**

```swift
let restConfig: SCRestConfiguration = 
	SCRestConfiguration(
		baseUrl: Constants.apiBaseUrl, 
		andAuthUrl: Constants.baseUrl
	)
```

**STOMP-Channel-Config (Persistent)**

```swift
let stompConfig: SCStompConfiguration = 
	SCStompConfiguration(
		host: "connect.secucard.com", 
		andVHost: "/", 
		port: "61614", 
		userId: "", 
		password: "", 
		useSSL: true, 
		replyQueue: "/temp-queue/main", 
		connectionTimeoutSec: 30, 
		socketTimeoutSec: 30, 
		heartbeatMs: 40000, 
		basicDestination: "/exchange/connect.api/"
	)
```

**Client Credentials**

Of course the clients needs to authorize agains the API. The client in this case can be an app but does not identify a single user. 

```swift
let clientCredentials: SCClientCredentials = 
	SCClientCredentials(
		clientId: "611c00ec6b2be6c77c2338774f50040x", 
		clientSecret: "dc1f422dde755f0b1c4ac04e7efabcc4c78870691fe783266d7d6c89439925eb"
	)
```

**User Credentials**

The user credentials identify and authorize a specific user of the client (aka App). 

```swift
let userCredentials: SCClientCredentials = 
	SCUserCredentials(
		username: "User", 
		andPassword: "pa**wo**"
	)
```

For your initialization workflow you can set the user credentials later using 

```swift
SCConnectClient.sharedInstance().setUserCredentials(userCredentials: SCUserCredentials)
```

**Client Configuration**

The client configuration now consists of the upper configurations and additional information like which channel is supposed to be the default channel or what the  auth type should be

```swift
let clientConfig: SCClientConfiguration = 
	SCClientConfiguration(
		restConfiguration: restConfig, 
		stompConfiguration: stompConfig, 
		defaultChannel: OnDemandChannel, 
		stompEnabled: true, 
		oauthUrl: Constants.baseUrl, 
		clientCredentials: clientCredentials, 
		userCredentials: userCredentials, 
		deviceId: uuid, 
		authType: "device"
	)     
```
**Initialization and connection**

You can now initialize the client like this

```swift
SCConnectClient.sharedInstance().initWithConfiguration(clientConfig)
```

and then connect to the service with

```swift
client.connect({ (success: Bool, error: SecuError?) -> Void in
  
  if let error = error {
    evaluate(error)
    return
  }
  
  if success {
    
    // -> connected, call your actions
    
  } else {
    
    print("Something went wrong")
    
  }
  
})
```

### AuthType

Depending on the authType you might need to take differnt actions. Usually the authorization takes place via username/password-combination. But if you are developing for a cashier app for example the API is asking you to enter a code in the service backend. So consider the method calls available for you in *SCAccountManager*
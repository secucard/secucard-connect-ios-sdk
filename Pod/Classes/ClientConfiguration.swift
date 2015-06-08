//
//  ClientConfiguration.swift
//  Pods
//
//  Created by Jörn Schmidt on 07.06.15.
//
//

struct ClientCredentials {
  
  var clientId: String
  var clientSecret: String

}

struct UserCredentials {
  
  var username: String
  var password: String
  
}

struct ClientConfiguration {
  
  var restConfiguration: RestConfiguration
  var stompConfiguration: StompConfiguration
  var defaultChannel: ServiceChannel
  var stompEnabled: Bool
  // TODO: needed? String cacheDir;
  // TODO: needed? Number authWaitTimeoutSec;
  var oauthUrl: String
  var clientCredentials: ClientCredentials
  var userCredentials: UserCredentials
  var deviceId: String
  var authType: String

  
}

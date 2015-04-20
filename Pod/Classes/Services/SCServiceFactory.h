//
//  SCServiceFactory.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import "SCAbstractService.h"

typedef enum ServiceType {
  
  GeneralPublicMerchantService,
  GeneralMerchantService,
  GeneralStoreService,
  GeneralNewsService,
  GeneralTransactionService,
  GeneralAccountService,
  GeneralAccountDevicesService,
  GeneralAppsSecuAppService,
  DocumentUploadService,
  LoyaltyCardsService,
  LoyaltyMerchantCardsService,
  LoyaltyCustomerService,
  ServicesIdentService,
  PaymentCustomerService,
  PaymentContainerService,
  PaymentSecupayDebitService,
  PaymentSecupayPrepayService,
  SmartIdentService,
  SmartTransactionService,
  SmartDeviceService,
  SmartCheckinService
  
} ServiceType;

@interface SCServiceFactory : NSObject

- (SCAbstractService*) getService:(ServiceType)serviceType;
//- (SCAbstractService*) getServiceById:(NSString*)serviceId;
//- (SCAbstractService*) getServiceByClass:(Class)serviceClass;

@end

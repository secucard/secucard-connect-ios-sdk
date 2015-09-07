//
//  SecucardConnectSDK.h
//  SecucardConnectSDK
//
//  Created by Jörn Schmidt on 18.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SecucardConnectSDK/SCConnectClient.h>
#import <SecucardConnectSDK/MTLModel+Secucard.h>
#import <SecucardConnectSDK/NSArray+NullStripper.h>
#import <SecucardConnectSDK/NSDictionary+NullStripper.h>
#import <SecucardConnectSDK/SCGlobals.h>
#import <SecucardConnectSDK/SCAccountManager.h>
#import <SecucardConnectSDK/SCAppDestination.h>
#import <SecucardConnectSDK/SCLogManager.h>
#import <SecucardConnectSDK/SCPersistenceManager.h>
#import <SecucardConnectSDK/SCRestConfiguration.h>
#import <SecucardConnectSDK/SCRestServiceManager.h>
#import <SecucardConnectSDK/SCServiceManager.h>
#import <SecucardConnectSDK/SCStompConfiguration.h>
#import <SecucardConnectSDK/SCStompDestination.h>
#import <SecucardConnectSDK/SCStompManager.h>
#import <SecucardConnectSDK/SCStompStorageItem.h>
#import <SecucardConnectSDK/SCAnnotationProductInfo.h>
#import <SecucardConnectSDK/SCAuthDeviceAuthCode.h>
#import <SecucardConnectSDK/SCAuthSession.h>
#import <SecucardConnectSDK/SCAuthToken.h>
#import <SecucardConnectSDK/SCAuthTokenNew.h>
#import <SecucardConnectSDK/SCDocumentUploadsDocument.h>
#import <SecucardConnectSDK/SCGeneralComponentsAddressComponent.h>
#import <SecucardConnectSDK/SCGeneralComponentsAssign.h>
#import <SecucardConnectSDK/SCGeneralComponentsDayTime.h>
#import <SecucardConnectSDK/SCGeneralComponentsGeometry.h>
#import <SecucardConnectSDK/SCGeneralComponentsMetaData.h>
#import <SecucardConnectSDK/SCGeneralComponentsOpenHours.h>
#import <SecucardConnectSDK/SCGeneralAccount.h>
#import <SecucardConnectSDK/SCGeneralAccountDevice.h>
#import <SecucardConnectSDK/SCGeneralAddress.h>
#import <SecucardConnectSDK/SCGeneralAssignment.h>
#import <SecucardConnectSDK/SCGeneralBeaconEnvironment.h>
#import <SecucardConnectSDK/SCGeneralContact.h>
#import <SecucardConnectSDK/SCGeneralEvent.h>
#import <SecucardConnectSDK/SCGeneralLocation.h>
#import <SecucardConnectSDK/SCGeneralMerchant.h>
#import <SecucardConnectSDK/SCGeneralMerchantDetail.h>
#import <SecucardConnectSDK/SCGeneralMerchantList.h>
#import <SecucardConnectSDK/SCGeneralNews.h>
#import <SecucardConnectSDK/SCGeneralNotification.h>
#import <SecucardConnectSDK/SCGeneralPublicMerchant.h>
#import <SecucardConnectSDK/SCGeneralStore.h>
#import <SecucardConnectSDK/SCGeneralStoreSetDefault.h>
#import <SecucardConnectSDK/SCGeneralTransaction.h>
#import <SecucardConnectSDK/SCLoyaltyBonus.h>
#import <SecucardConnectSDK/SCLoyaltyCard.h>
#import <SecucardConnectSDK/SCLoyaltyCardGroup.h>
#import <SecucardConnectSDK/SCLoyaltyCondition.h>
#import <SecucardConnectSDK/SCLoyaltyCustomer.h>
#import <SecucardConnectSDK/SCLoyaltyMerchantCard.h>
#import <SecucardConnectSDK/SCLoyaltyProgram.h>
#import <SecucardConnectSDK/SCLoyaltySale.h>
#import <SecucardConnectSDK/SCPaymentContainer.h>
#import <SecucardConnectSDK/SCPaymentContract.h>
#import <SecucardConnectSDK/SCPaymentCustomer.h>
#import <SecucardConnectSDK/SCPaymentData.h>
#import <SecucardConnectSDK/SCPaymentSecupayDebit.h>
#import <SecucardConnectSDK/SCPaymentSecupayPrepay.h>
#import <SecucardConnectSDK/SCPaymentTransaction.h>
#import <SecucardConnectSDK/SCPaymentTransferAccount.h>
#import <SecucardConnectSDK/SCGeoQuery.h>
#import <SecucardConnectSDK/SCMediaResource.h>
#import <SecucardConnectSDK/SCObjectList.h>
#import <SecucardConnectSDK/SCQueryParams.h>
#import <SecucardConnectSDK/SCSecuObject.h>
#import <SecucardConnectSDK/SCServiceCallWrapper.h>
#import <SecucardConnectSDK/SCServiceEventObject.h>
#import <SecucardConnectSDK/SCServicesIdRequestPerson.h>
#import <SecucardConnectSDK/SCServicesIdResultAddress.h>
#import <SecucardConnectSDK/SCServicesIdResultAttachment.h>
#import <SecucardConnectSDK/SCServicesIdResultContactData.h>
#import <SecucardConnectSDK/SCServicesIdResultCustomData.h>
#import <SecucardConnectSDK/SCServicesIdResultIdentificationDocument.h>
#import <SecucardConnectSDK/SCServicesIdResultIdentificationProcess.h>
#import <SecucardConnectSDK/SCServicesIdResultPerson.h>
#import <SecucardConnectSDK/SCServicesIdResultUserData.h>
#import <SecucardConnectSDK/SCServicesIdResultValue.h>
#import <SecucardConnectSDK/SCServicesContract.h>
#import <SecucardConnectSDK/SCServicesIdentRequest.h>
#import <SecucardConnectSDK/SCServicesIdentResult.h>
#import <SecucardConnectSDK/SCSmartBasket.h>
#import <SecucardConnectSDK/SCSmartBasketInfo.h>
#import <SecucardConnectSDK/SCSmartCashierDisplay.h>
#import <SecucardConnectSDK/SCSmartCheckin.h>
#import <SecucardConnectSDK/SCSmartDevice.h>
#import <SecucardConnectSDK/SCSmartIdent.h>
#import <SecucardConnectSDK/SCSmartProduct.h>
#import <SecucardConnectSDK/SCSmartProductGroup.h>
#import <SecucardConnectSDK/SCSmartReceiptLine.h>
#import <SecucardConnectSDK/SCSmartText.h>
#import <SecucardConnectSDK/SCSmartTransaction.h>
#import <SecucardConnectSDK/SCSmartTransactionResult.h>
#import <SecucardConnectSDK/SCTransportMessage.h>
#import <SecucardConnectSDK/SCTransportResult.h>
#import <SecucardConnectSDK/SCTransportStatus.h>
#import <SecucardConnectSDK/SCClientConfiguration.h>
#import <SecucardConnectSDK/SCClientCredentials.h>
#import <SecucardConnectSDK/SCUserCredentials.h>
#import <SecucardConnectSDK/SCUploadService.h>
#import <SecucardConnectSDK/SCSecuAppService.h>
#import <SecucardConnectSDK/SCAccountDevicesService.h>
#import <SecucardConnectSDK/SCAccountService.h>
#import <SecucardConnectSDK/SCMerchantService.h>
#import <SecucardConnectSDK/SCNewsService.h>
#import <SecucardConnectSDK/SCPublicMerchantService.h>
#import <SecucardConnectSDK/SCStoreService.h>
#import <SecucardConnectSDK/SCTransactionService.h>
#import <SecucardConnectSDK/SCCardsService.h>
#import <SecucardConnectSDK/SCLoyaltyCustomerService.h>
#import <SecucardConnectSDK/SCMerchantCardsService.h>
#import <SecucardConnectSDK/SCContainerService.h>
#import <SecucardConnectSDK/SCCustomerService.h>
#import <SecucardConnectSDK/SCSecupayDebitService.h>
#import <SecucardConnectSDK/SCSecupayPrepayService.h>
#import <SecucardConnectSDK/SCAbstractService.h>
#import <SecucardConnectSDK/SCIdentService.h>
#import <SecucardConnectSDK/SCCheckinService.h>
#import <SecucardConnectSDK/SCDeviceService.h>
#import <SecucardConnectSDK/SCSmartIdentService.h>
#import <SecucardConnectSDK/SCSmartTransactionService.h>
#import <SecucardConnectSDK/StompKit.h>

//! Project version number for SecucardConnectSDK.
FOUNDATION_EXPORT double SecucardConnectSDKVersionNumber;

//! Project version string for SecucardConnectSDK.
FOUNDATION_EXPORT const unsigned char SecucardConnectSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SecucardConnectSDK/PublicHeader.h>



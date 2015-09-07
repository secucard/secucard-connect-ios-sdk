//
//  SecucardConnectClient.h
//  SecucardConnectClient
//
//  Created by Jörn Schmidt on 18.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SecucardConnectClient/SCConnectClient.h>
#import <SecucardConnectClient/MTLModel+Secucard.h>
#import <SecucardConnectClient/NSArray+NullStripper.h>
#import <SecucardConnectClient/NSDictionary+NullStripper.h>
#import <SecucardConnectClient/SCGlobals.h>
#import <SecucardConnectClient/SCAccountManager.h>
#import <SecucardConnectClient/SCAppDestination.h>
#import <SecucardConnectClient/SCLogManager.h>
#import <SecucardConnectClient/SCPersistenceManager.h>
#import <SecucardConnectClient/SCRestConfiguration.h>
#import <SecucardConnectClient/SCRestServiceManager.h>
#import <SecucardConnectClient/SCServiceManager.h>
#import <SecucardConnectClient/SCStompConfiguration.h>
#import <SecucardConnectClient/SCStompDestination.h>
#import <SecucardConnectClient/SCStompManager.h>
#import <SecucardConnectClient/SCStompStorageItem.h>
#import <SecucardConnectClient/SCAnnotationProductInfo.h>
#import <SecucardConnectClient/SCAuthDeviceAuthCode.h>
#import <SecucardConnectClient/SCAuthSession.h>
#import <SecucardConnectClient/SCAuthToken.h>
#import <SecucardConnectClient/SCAuthTokenNew.h>
#import <SecucardConnectClient/SCDocumentUploadsDocument.h>
#import <SecucardConnectClient/SCGeneralComponentsAddressComponent.h>
#import <SecucardConnectClient/SCGeneralComponentsAssign.h>
#import <SecucardConnectClient/SCGeneralComponentsDayTime.h>
#import <SecucardConnectClient/SCGeneralComponentsGeometry.h>
#import <SecucardConnectClient/SCGeneralComponentsMetaData.h>
#import <SecucardConnectClient/SCGeneralComponentsOpenHours.h>
#import <SecucardConnectClient/SCGeneralAccount.h>
#import <SecucardConnectClient/SCGeneralAccountDevice.h>
#import <SecucardConnectClient/SCGeneralAddress.h>
#import <SecucardConnectClient/SCGeneralAssignment.h>
#import <SecucardConnectClient/SCGeneralBeaconEnvironment.h>
#import <SecucardConnectClient/SCGeneralContact.h>
#import <SecucardConnectClient/SCGeneralEvent.h>
#import <SecucardConnectClient/SCGeneralLocation.h>
#import <SecucardConnectClient/SCGeneralMerchant.h>
#import <SecucardConnectClient/SCGeneralMerchantDetail.h>
#import <SecucardConnectClient/SCGeneralMerchantList.h>
#import <SecucardConnectClient/SCGeneralNews.h>
#import <SecucardConnectClient/SCGeneralNotification.h>
#import <SecucardConnectClient/SCGeneralPublicMerchant.h>
#import <SecucardConnectClient/SCGeneralStore.h>
#import <SecucardConnectClient/SCGeneralStoreSetDefault.h>
#import <SecucardConnectClient/SCGeneralTransaction.h>
#import <SecucardConnectClient/SCLoyaltyBonus.h>
#import <SecucardConnectClient/SCLoyaltyCard.h>
#import <SecucardConnectClient/SCLoyaltyCardGroup.h>
#import <SecucardConnectClient/SCLoyaltyCondition.h>
#import <SecucardConnectClient/SCLoyaltyCustomer.h>
#import <SecucardConnectClient/SCLoyaltyMerchantCard.h>
#import <SecucardConnectClient/SCLoyaltyProgram.h>
#import <SecucardConnectClient/SCLoyaltySale.h>
#import <SecucardConnectClient/SCPaymentContainer.h>
#import <SecucardConnectClient/SCPaymentContract.h>
#import <SecucardConnectClient/SCPaymentCustomer.h>
#import <SecucardConnectClient/SCPaymentData.h>
#import <SecucardConnectClient/SCPaymentSecupayDebit.h>
#import <SecucardConnectClient/SCPaymentSecupayPrepay.h>
#import <SecucardConnectClient/SCPaymentTransaction.h>
#import <SecucardConnectClient/SCPaymentTransferAccount.h>
#import <SecucardConnectClient/SCGeoQuery.h>
#import <SecucardConnectClient/SCMediaResource.h>
#import <SecucardConnectClient/SCObjectList.h>
#import <SecucardConnectClient/SCQueryParams.h>
#import <SecucardConnectClient/SCSecuObject.h>
#import <SecucardConnectClient/SCServiceCallWrapper.h>
#import <SecucardConnectClient/SCServiceEventObject.h>
#import <SecucardConnectClient/SCServicesIdRequestPerson.h>
#import <SecucardConnectClient/SCServicesIdResultAddress.h>
#import <SecucardConnectClient/SCServicesIdResultAttachment.h>
#import <SecucardConnectClient/SCServicesIdResultContactData.h>
#import <SecucardConnectClient/SCServicesIdResultCustomData.h>
#import <SecucardConnectClient/SCServicesIdResultIdentificationDocument.h>
#import <SecucardConnectClient/SCServicesIdResultIdentificationProcess.h>
#import <SecucardConnectClient/SCServicesIdResultPerson.h>
#import <SecucardConnectClient/SCServicesIdResultUserData.h>
#import <SecucardConnectClient/SCServicesIdResultValue.h>
#import <SecucardConnectClient/SCServicesContract.h>
#import <SecucardConnectClient/SCServicesIdentRequest.h>
#import <SecucardConnectClient/SCServicesIdentResult.h>
#import <SecucardConnectClient/SCSmartBasket.h>
#import <SecucardConnectClient/SCSmartBasketInfo.h>
#import <SecucardConnectClient/SCSmartCashierDisplay.h>
#import <SecucardConnectClient/SCSmartCheckin.h>
#import <SecucardConnectClient/SCSmartDevice.h>
#import <SecucardConnectClient/SCSmartIdent.h>
#import <SecucardConnectClient/SCSmartProduct.h>
#import <SecucardConnectClient/SCSmartProductGroup.h>
#import <SecucardConnectClient/SCSmartReceiptLine.h>
#import <SecucardConnectClient/SCSmartText.h>
#import <SecucardConnectClient/SCSmartTransaction.h>
#import <SecucardConnectClient/SCSmartTransactionResult.h>
#import <SecucardConnectClient/SCTransportMessage.h>
#import <SecucardConnectClient/SCTransportResult.h>
#import <SecucardConnectClient/SCTransportStatus.h>
#import <SecucardConnectClient/SCClientConfiguration.h>
#import <SecucardConnectClient/SCClientCredentials.h>
#import <SecucardConnectClient/SCUserCredentials.h>
#import <SecucardConnectClient/SecucardConnectClient.h>
#import <SecucardConnectClient/SCUploadService.h>
#import <SecucardConnectClient/SCSecuAppService.h>
#import <SecucardConnectClient/SCAccountDevicesService.h>
#import <SecucardConnectClient/SCAccountService.h>
#import <SecucardConnectClient/SCMerchantService.h>
#import <SecucardConnectClient/SCNewsService.h>
#import <SecucardConnectClient/SCPublicMerchantService.h>
#import <SecucardConnectClient/SCStoreService.h>
#import <SecucardConnectClient/SCTransactionService.h>
#import <SecucardConnectClient/SCCardsService.h>
#import <SecucardConnectClient/SCLoyaltyCustomerService.h>
#import <SecucardConnectClient/SCMerchantCardsService.h>
#import <SecucardConnectClient/SCContainerService.h>
#import <SecucardConnectClient/SCCustomerService.h>
#import <SecucardConnectClient/SCSecupayDebitService.h>
#import <SecucardConnectClient/SCSecupayPrepayService.h>
#import <SecucardConnectClient/SCAbstractService.h>
#import <SecucardConnectClient/SCIdentService.h>
#import <SecucardConnectClient/SCCheckinService.h>
#import <SecucardConnectClient/SCDeviceService.h>
#import <SecucardConnectClient/SCSmartIdentService.h>
#import <SecucardConnectClient/SCSmartTransactionService.h>
#import <SecucardConnectClient/StompKit.h>

//! Project version number for SecucardConnectClient.
FOUNDATION_EXPORT double SecucardConnectClientVersionNumber;

//! Project version string for SecucardConnectClient.
FOUNDATION_EXPORT const unsigned char SecucardConnectClientVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SecucardConnectClient/PublicHeader.h>



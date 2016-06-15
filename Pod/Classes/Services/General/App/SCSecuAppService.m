//
//  SCSecuAppService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSecuAppService.h"
#import "SCGeneralStore.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "AFNetworking.h"
#import "AFImageDownloader.h"

@implementation SCStoreList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)dataJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCGeneralStore class]];
}

@end

@implementation SCSecuAppService

+ (SCSecuAppService*)sharedService
{
  static SCSecuAppService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCSecuAppService new];
  });
  
  return instance;
}

- (void)getMerchant:(NSString *)appId argObject:(id)argObject completionHandler:(void (^)(SCObjectList *list, SecuError *error))handler {

  [SCLogManager info:@"CONNECT-SDK: getMerchant"];
  
  [self execute:appId action:@"callBackend/getMerchantDetails" arg:argObject returnType:[SCObjectList class] onChannel:OnDemandChannel completionHandler:^(id list, SecuError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCObjectList *storeList = [MTLJSONAdapter modelOfClass:SCObjectList.class fromJSONDictionary:list error:&parsingError];
    
    if (parsingError != nil) {
      handler(nil, [SecuError withError:parsingError]);
      return;
    }
    
    handler(storeList, nil);
    
  }];
  
}

- (void)getMerchants:(NSString *)appId arg:(SCQueryParams *)arg completionHandler:(void (^)(SCObjectList *list, SecuError *error))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getMyMerchants"];
  
  [self execute:appId action:@"callBackend/getMyMerchants" arg:arg returnType:[SCObjectList class] onChannel:OnDemandChannel completionHandler:^(id list, SecuError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCObjectList *storeList = [MTLJSONAdapter modelOfClass:SCObjectList.class fromJSONDictionary:list error:&parsingError];
    
    if (parsingError != nil) {
      handler(nil, [SecuError withError:parsingError]);
      return;
    }
    
    if (storeList.data.count == 0) {
      handler(storeList, nil);
      return;
    }
    
    handler(storeList, nil);
    
    return;
    
    // preload images
    __block int loaded = 0;
    
    for (NSDictionary *store in storeList.data) {
      
      NSURL *url = [NSURL URLWithString:[store objectForKey:@"photoMain"]];
      __block NSURLRequest *request = [NSURLRequest requestWithURL:url];
      [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
          NSLog(@"sendAsynchronousRequest error: %@", connectionError);
        } else {
          
          UIImage *img = [UIImage safeImageWithData:data];
          [[UIImageView sharedImageDownloader] downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        
            loaded++;
            if (loaded == storeList.data.count) {
              handler(storeList, nil);
            }
            
          } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
            loaded++;
            if (loaded == storeList.data.count) {
              handler(storeList, nil);
            }
            
          }];
        }
        
        
      }];
      
    }
    
  }];
}

- (void)addCard:(NSString *)appId argObject:(id)argObject completionHandler:(void (^)(bool, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: addCard"];
  
  [self execute:appId action:@"callBackend/addCard" arg:argObject returnType:[NSDictionary class] onChannel:OnDemandChannel completionHandler:^(id responseObject, SecuError *error) {
    
    handler((error == nil), error);
    
  }];
}

@end

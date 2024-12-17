//
//  GluedInBridge.m
//  GluedInSample
//
//  Created by sahil on 04/09/24.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(GluedInBridge, NSObject)

RCT_EXTERN_METHOD(launchSDK:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(initializeSDKOnLaunch:(NSString *)apiKey secretKey:(NSString *)secretKey callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(performLogin:(NSString *)username password:(NSString *)password callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(performSignup:(NSString *)name email:(NSString *)email password:(NSString *)password username:(NSString *)username callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(getDiscoverSearchInAllVideoRails:(NSString *)searchText callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(handleClickedEvents:(NSString *)event eventID:(NSString *)eventID callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(userDidTapOnFeed:(NSString *)type feed:(NSDictionary *)feed callback:(RCTResponseSenderBlock)callback)
@end

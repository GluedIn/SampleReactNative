/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateModuleObjCpp
 *
 * We create an umbrella header (and corresponding implementation) here since
 * Cxx compilation in BUCK has a limitation: source-code producing genrule()s
 * must have a single output. More files => more genrule()s => slower builds.
 */

#ifndef __cplusplus
#error This file must be compiled as Obj-C++. If you are importing it, you must change your file extension to .mm.
#endif

// Avoid multiple includes of RNGoogleMobileAdsSpec symbols
#ifndef RNGoogleMobileAdsSpec_H
#define RNGoogleMobileAdsSpec_H

#import <Foundation/Foundation.h>
#import <RCTRequired/RCTRequired.h>
#import <RCTTypeSafety/RCTConvertHelpers.h>
#import <RCTTypeSafety/RCTTypedModuleConstants.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTCxxConvert.h>
#import <React/RCTManagedPointer.h>
#import <ReactCommon/RCTTurboModule.h>
#import <optional>
#import <vector>


@protocol NativeGoogleMobileAdsModuleSpec <RCTBridgeModule, RCTTurboModule>

- (void)initialize:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject;
- (void)setRequestConfiguration:(NSDictionary *)requestConfiguration
                        resolve:(RCTPromiseResolveBlock)resolve
                         reject:(RCTPromiseRejectBlock)reject;
- (void)openAdInspector:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject;
- (void)openDebugMenu:(NSString *)adUnit;
- (void)setAppVolume:(double)volume;
- (void)setAppMuted:(BOOL)muted;

@end
namespace facebook::react {
  /**
   * ObjC++ class for module 'NativeGoogleMobileAdsModule'
   */
  class JSI_EXPORT NativeGoogleMobileAdsModuleSpecJSI : public ObjCTurboModule {
  public:
    NativeGoogleMobileAdsModuleSpecJSI(const ObjCTurboModule::InitParams &params);
  };
} // namespace facebook::react

#endif // RNGoogleMobileAdsSpec_H
//
//  GluedInBridge.swift
//  GluedInSample
//
//  Created by sahil on 04/09/24.
//

import Foundation
import React
import GluedInSDK
import GluedInCoreSDK
import GluedInCreatorSDK
import GluedInFeedSDK
import UIKit

@objc(GluedInBridge)
class GluedInBridge: RCTEventEmitter {
  
  //MARK: - Supported events for callback-
  override func supportedEvents() -> [String]! {
    return ["onSignInClick","onSignUpClick"]
  }
  
  //MARK: - Initialize SDK on Launch -
  @objc
  func initializeSDKOnLaunch(_ apiKey: String, secretKey: String, callback: @escaping RCTResponseSenderBlock) {
    GluedInCore.shared.initSdk(apiKey: apiKey,
                               secretKey: secretKey) {
      callback([NSNull(), "Initialize successful"])
    } failure: { error, code in
      callback([error, NSNull()])
    }
  }
  
  //MARK: - Launch SDK as guest -
  @objc
  func launchSDK(_ callback: @escaping RCTResponseSenderBlock) {
    launchSDKAsGuest { isSuccess, error in
      callback([NSNull(), "Launch successful"])
    }
  }
  
  //MARK: - Perform Login -
  @objc
  func performLogin(_ username: String, password: String, callback: @escaping RCTResponseSenderBlock) {
    launchSDKwithUserName(email: username, password: password) { isSuccess, errorMessage in
      if isSuccess{
        callback([NSNull(), "Login successful"])
      }else{
        callback([errorMessage, NSNull()])
      }
    }
  }
  
  
  //MARK: - Perform Signup-
  @objc
  func performSignup(_ name: String, email: String, password: String, username: String, callback: @escaping RCTResponseSenderBlock) {
    registerUser(fullName: name, username: username, email: email, password: password) { isSuccess, errorMessage in
      if isSuccess{
        callback([NSNull(), "register success"])
      }else{
        callback([errorMessage, NSNull()])
      }
    }
  }
  
  //MARK: - User clicked on Hashtag, challenges -
  @objc
  func handleClickedEvents(_ event: String, eventID: String, callback: @escaping RCTResponseSenderBlock) {
    
    switch EventTypes(rawValue: event){
    case .hashTagClick:
      print("hashtag click with ID======>",eventID)
    case .challengeClick:
      print("challenge click with ID=====->",eventID)
    case .none:
      print("none")
    }
  }
  
  //MARK: - SubFeed from the Rail list with selected Item -
  @objc func userDidTapOnFeed(_ type: String, feed : NSDictionary, callback: @escaping RCTResponseSenderBlock){
    if let feedModel = feed as? [String:Any]{
      if let videoObject = feedModel["video"] as? [String:Any]{
        if let model = FeedModel(JSON: videoObject){
          //            let controller = GluedInFeed.shared.getFeedViewControllerWithUrlAndVideos(context: .feed,
          //                                                                                      url: "",
          //                                                                                      searchText: "",
          //                                                                                      sourcePageName: "",
          //                                                                                      currentPage: 1,
          //                                                                                      videos: [model],
          //                                                                                      index: 0,
          //                                                                                      delegate: nil,
          //                                                                                      isBackEnable: true)
          
//          let controller = GluedInFeed.shared.getVerticalFeedViewControllerWithUrlAndVideos(
//            context: .feed,
//            url: "",
//            searchText: "",
//            sourcePageName: "",
//            currentPage: 1,
//            videos: [model],
//            index: 0,
//            delegate: nil,
//            isBackEnable: true)
//          DispatchQueue.main.async {
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//              return
//            }
//            if let navVC = appDelegate.window.rootViewController as? UINavigationController{
//              navVC.pushViewController(controller!, animated: true)
//            }
//          }
          
          if let controller = GluedIn.shared.rootControllerWithSignIn(
            userType: "SVOD",
            adsParameter: nil,
            delegate: self){
            DispatchQueue.main.async {
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
              }
              if let navVC = appDelegate.window.rootViewController as? UINavigationController{
                if let topVC = self.topViewController(){
                  appDelegate.reactNativeViewController = topVC
                }
                navVC.pushViewController(controller, animated: true)
                //completion(true,"")
              }
            }
          }
        }
      }
    }
  }
  
  //MARK: - Fetch curated rails-
  @objc
  func getDiscoverSearchInAllVideoRails(_ searchText: String, callback: @escaping RCTResponseSenderBlock) {
//    DiscoverData.sharedInstance.getSearchedVideoList(searchText: "", limit: 50, offset: 1) { videosModel in
//      if videosModel.result != nil{
////        print("get disciver model data",videosModel.result)
//        callback([NSNull(), videosModel.toJSON()])
//      }else{
//        callback(["No data found", NSNull()])
//      }
//    } failure: { error, code in
//      callback([error, NSNull()])
//    }
    
    DiscoverData.sharedInstance.getCuratedRailList(limit: 50, offset: 1) { curationData in
      print("curationData",curationData.toJSON())
      if curationData.result != nil{
        //        print("get disciver model data",videosModel.result)
        callback([NSNull(), curationData.toJSON()])
      }else{
        callback(["No data found", NSNull()])
      }
    } failure: { errorMessage, code in
      callback([errorMessage, NSNull()])
    }

  }
  
  //MARK: - open react natve controller and pass event-
  func openParentClassWithEvent(event: String, body: Any){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
        if let rootView = appDelegate.reactNativeViewController{
          let navigationVC = UINavigationController(rootViewController: rootView)
          navigationVC.navigationBar.isHidden = true
          appDelegate.window.rootViewController = navigationVC
          appDelegate.window.makeKeyAndVisible()
        }
      self.sendEvent(withName: event, body: body) // send event to react native
    })
  }
  
  
  
  // launch with email and username
  func launchSDKwithUserName(email: String, password: String, completion: @escaping((_ isSuccess: Bool,_ errorMessage: String)-> Void)){
    GluedIn.shared.quickLaunch(email: email,
                               password: password,
                               firebaseToken: "",
                               deviceId: "",
                               deviceType: "ios",
                               fullName: "",
                               autoCreate: false,
                               termConditionAccepted: true,
                               userType: "SVOD",
                               adsParameter: nil,
                               delegate: self) { controller in
      guard let viewController = controller else { return }
      DispatchQueue.main.async {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        if let navVC = appDelegate.window.rootViewController as? UINavigationController{
          navVC.pushViewController(viewController, animated: true)
        }
      }
      completion(true,"")
    } failure: { error, code in
      completion(false,error)
    }
  }
  
//  signup on SDK
  func registerUser(fullName: String,
                          username: String,
                          email: String,
                          password: String,
                          completion: @escaping((_ isSuccess: Bool,_ errorMessage: String)-> Void)){
    Auth.sharedInstance.registerUser(
      fullName: fullName,
      email: email,
      password: password,
      userName: username,
      termConditionAccepted: true,
      invitationCode: "") { message in
        completion(true,"")
      } failure: { error, code in
        completion(false,error)
      }
  }
  
  //guest login
  func launchSDKAsGuest(completion: @escaping((_ isSuccess: Bool,_ errorMessage: String)-> Void)){
    if let controller = GluedIn.shared.rootControllerWithSignIn(
      userType: "SVOD",
      adsParameter: nil,
      delegate: self){
      DispatchQueue.main.async {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        if let navVC = appDelegate.window.rootViewController as? UINavigationController{
          if let topVC = self.topViewController(){
            appDelegate.reactNativeViewController = topVC
          }
          navVC.pushViewController(controller, animated: true)
          completion(true,"")
        }
      }
    }
  }
  
  //MARK: - get top controller -
  func topViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
    if let navigationController = base as? UINavigationController {
      return topViewController(base: navigationController.visibleViewController)
    } else if let tabBarController = base as? UITabBarController {
      if let selected = tabBarController.selectedViewController {
        return topViewController(base: selected)
      }
    } else if let presented = base?.presentedViewController {
      return topViewController(base: presented)
    }
    return base
  }
  
}

//// For GAD Callbacks and methods
//extension GluedInBridge: GluedInDelegate{
//  
//}

// For FaceBook Share callbacks methods
extension GluedInBridge: CreatorProtocol{
  func contentSocialShare(contentURL: String, title: String, description: String, thumbnailImage: UIImage) {
      print(" contentSocialShare Method ")
  }
}

//MARK: - Extension -
extension GluedInBridge : GluedInDelegate{
  func requestForBannerView(viewController: UIViewController?) -> UIView {
      guard let bannerView = GADBannerManager().createRequestForBannerView(viewController: viewController) else {
          return UIView()  // Return an empty view if the banner creation fails
      }
      return bannerView  // Return the bannerView directly as UIView
  }
  
  func requestForAdsInter(view: UIViewController) {
    // Write code for Intertital Ads
    GADInterstitialManager.shared.loadInterstitialAds { [weak self] didCompleted in
        debugPrint(didCompleted)
        self?.getNativeAdControllerInter(view: view)
    } didCompleteWithError: { didCompleteWithError in
        debugPrint("didCompleteWithError \(didCompleteWithError)")
    }
  }
  
  func getNativeAdControllerInter(view: UIViewController) {
      GADInterstitialManager.shared.showInterstitialAds(
          view: view,
          didPresent: {
              debugPrint("In Present")
          },
          didDismiss: {
              debugPrint("didDismiss")
          },
          didFailToPresent: { didFailToPresentWithError in
              debugPrint("didFailToPresent")
          })
  }
  
  func getNativeAdNibName() -> String {
    // Write code for Native Ad on card based feed cell
    // It will return the table view cell name
    return "UnifiedNativeAdCell"
  }
  
  func requestNativeAdCell() -> UITableViewCell {
    // Write code for Native Ad on card based feed cell
    // It will return the table view cell which GlueDIn use with in the cell
    let nativeAdCell = UnifiedNativeAdCell(style: .default, reuseIdentifier: "UnifiedNativeAdCellIdentifier")
    // Access the adView directly since it is now initialized programmatically in the UnifiedNativeAdCell class
    let adView = nativeAdCell.adView
//    if let adView = adView {
//        // Successfully accessed adView, you can configure or use it here
//        print("Successfully accessed GADNativeAdView")
//    } else {
//        // Handle the case where adView is nil, though it should not be in this programmatic setup
//        print("adView is nil")
//    }
    // Configure the ad cell with a GADNativeAd
    nativeAdCell.nativeAdsLoader(requiredNumberOfAds: 1) { nativeAd in
        //nativeAd.rootViewController = self
        adView?.nativeAd = nativeAd
        adView?.mediaView?.mediaContent = nativeAd?.mediaContent
        if let mediaView = adView?.mediaView,
           nativeAd?.mediaContent.aspectRatio ?? 0 > 0 {
            let heightConstraint = NSLayoutConstraint(
                item: mediaView,
                attribute: .height,
                relatedBy: .equal,
                toItem: mediaView,
                attribute: .width,
                multiplier: CGFloat(1 / (nativeAd?.mediaContent.aspectRatio ?? 1)),
                constant: 0)
            heightConstraint.isActive = true
        }
        (adView?.headlineView as? UILabel)?.text = nativeAd?.headline
        adView?.headlineView?.isHidden = nativeAd?.headline == nil
        
        (adView?.bodyView as? UILabel)?.text = nativeAd?.body
        adView?.bodyView?.isHidden = nativeAd?.body == nil
        
        adView?.callToActionView?.layer.cornerRadius = (adView?.callToActionView?.frame.height ?? 0) / 2
        (adView?.callToActionView as? UIButton)?.setTitleColor(.white, for: .normal)
        adView?.callToActionView?.backgroundColor = .blue
        (adView?.callToActionView as? UIButton)?.setTitle(nativeAd?.callToAction, for: .normal)
        adView?.callToActionView?.isHidden = nativeAd?.callToAction == nil
        adView?.callToActionView?.isUserInteractionEnabled = false
        adView?.iconView?.layer.cornerRadius = (adView?.iconView?.frame.height ?? 0) / 2
        adView?.iconView?.layer.borderColor = UIColor.white.cgColor
        adView?.iconView?.layer.borderWidth = 1
        (adView?.iconView as? UIImageView)?.image = nativeAd?.icon?.image
        adView?.iconView?.isHidden = nativeAd?.icon == nil
    }

    //nativeAdCell.updateUI()
    return nativeAdCell
  }
  
  func getNativeAdController() -> UIViewController? {
    // Write code for Native Ad controller for vertical feed
    return UIViewController()
  }
  
  func firebaseAnalyticsEvent(name: String, properties: [String : Any]) {
    // Write code for Firebase analytics
  }
  
  func appScreenViewEvent(journeyEntryPoint: String, deviceID: String, userEmail: String, userName: String, userId: String, version: String, platformName: String, pageName: String) {
    //
  }
  
  func appViewMoreEvent(Journey_entry_point: String, device_ID: String, user_email: String, user_name: String, platform_name: String, page_name: String, tab_name: String, element: String, button_type: String) {
    //
  }
  
  func appContentUnLikeEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appContentLikeEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appVideoReplayEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appSessionEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appVideoPlayEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appVideoPauseEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appVideoResumeEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appCommentsViewedEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appCommentedEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appContentNextEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appContentPreviousEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appVideoStopEvent(device_ID: String, content_id: String, user_email: String, user_name: String, user_id: String, platform_name: String, page_name: String, tab_name: String, creator_userid: String, creator_username: String, hashtag: String, content_type: String, gluedIn_version: String, played_duration: String, content_creator_id: String, dialect_id: String, dialect_language: String, genre: String, genre_id: String, shortvideo_labels: String, video_duration: String, feed: GluedInCoreSDK.FeedModel?) {
    //
  }
  
  func appViewClickEvent(device_ID: String, user_email: String, user_name: String, user_id: String, platform_name: String, page_name: String, tab_name: String, content_type: String, button_type: String, cta_name: String, gluedIn_version: String, feed: GluedInCoreSDK.FeedModel?) {
    //
  }
  
  func appUserFollowEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appUserUnFollowEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appCTAClickedEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appProfileEditEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appExitEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appClickHashtagEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appClickSoundTrackEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appContentMuteEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appContentUnmuteEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func didSelectBack() {
    //
  }
  
  func onGluedInShareAction(shareData: GluedInCoreSDK.ShareData) {
    //
  }
  
  func appSkipLoginEvent(device_ID: String, platform_name: String, page_name: String) {
    //
  }
  
  func didSelectParentApp() {
    //
  }
  
  func appTabClickEvent(Journey_entry_point: String, device_ID: String, user_email: String, user_name: String, user_id: String, platform_name: String, page_name: String, tab_name: String, button_type: String, cta_name: String, gluedIn_version: String, played_duration: String, content_creator_id: String, video_duration: String) {
    //
  }
  
  func appRegisterCTAClickEvent(device_ID: String, user_email: String, user_name: String, user_isFollow: String, user_following_count: String, user_follower_count: String, platform_name: String, page_name: String) {
    //
  }
  
  func appLoginCTAClickEvent(device_ID: String, user_email: String, user_name: String, user_id: String, user_isFollow: String, user_following_count: String, user_follower_count: String, platform_name: String, page_name: String, tab_name: String, button_type: String, cta_name: String, gluedIn_version: String, content_creator_id: String, video_duration: String) {
    //
  }
  
  func callClientSignInView() {
    self.openParentClassWithEvent(event: "onSignInClick", body: ["message":"now open sigin view controller"])
  }
  
  func callClientSignUpView() {
    self.openParentClassWithEvent(event: "onSignUpClick", body: ["message":"now open signup view controller"])
  }
  
  func appThumbnailClickEvent(device_ID: String, user_email: String, user_name: String, user_id: String, platform_name: String, page_name: String, tab_name: String, vertical_index: String, horizontal_index: String, element: String, content_type: String, content_genre: String, button_type: String, cta_name: String, gluedIn_version: String, content_creator_id: String, shortvideo_labels: String) {
    //
  }
  
  func appLaunchEvent(email: String, username: String, userId: String, version: String, deviceID: String, platformName: String) {
    //
  }
  
  func appChallengeJoinEvent(page_name: String, tab_name: String, element: String, button_type: String) {
    //
  }
  
  func appSearchButtonClickEvent(eventName: String?, params: [String : Any]?) {
    //
  }
  
  func appChallengeShareClickEvent(device_ID: String, user_email: String, user_name: String, platform_name: String, page_name: String, tab_name: String, element: String, button_type: String, success: String, failure_reason: String, creator_userid: String, creator_username: String) {
    //
  }
  
  func appCreatorRecordingDoneEvent() {
    //
  }
  
  func appCameraOpenEvent() {
    //
  }
  
  func appCreatorFilterAddedEvent() {
    //
  }
  
  func appCreatorMusicAddedEvent() {
    ///
  }
  
  func appCTAsClickEvent(device_ID: String, user_email: String, user_name: String, user_id: String, platform_name: String, page_name: String, tab_name: String, element: String, button_type: String, success: String, failure_reason: String, cta_name: String, gluedIn_version: String, played_duration: String, content_creator_id: String, video_duration: String) {
    //
  }
  
  func appPopupLaunchEvent(device_ID: String, user_email: String, user_name: String, platform_name: String, page_name: String, tab_name: String, popup_name: String, cta_name: String, user_id: String, gluedIn_version: String, content_creator_id: String, video_duration: String) {
    //
  }
  
  func appPopupCTAsEvent(device_ID: String, user_email: String, user_name: String, user_id: String, platform_name: String, page_name: String, tab_name: String, element: String, button_type: String, popup_name: String, cta_name: String, gluedIn_version: String, played_duration: String, content_creator_id: String, video_duration: String) {
    //
  }
  
  func appCreatePostEvent(device_ID: String, user_email: String, user_name: String, platform_name: String, page_name: String, tab_name: String, element: String, button_type: String, success: String, failure_reason: String, creator_userid: String, creator_username: String, hashtag: String, content_type: String, content_genre: String) {
    //
  }
  
  func appViewLeaderboardEvent(Journey_entry_point: String, device_ID: String, user_email: String, user_name: String, platform_name: String, page_name: String, tab_name: String, element: String, button_type: String) {
    //
  }
  
  func appUseThisHashtagEvent(device_ID: String, user_email: String, user_name: String, platform_name: String, page_name: String, tab_name: String, element: String, button_type: String, hashtag: String, content_type: String, content_genre: String) {
    //
  }
  
  func onUserProfileClick(userId: String) {
    //
  }
  
  func requestForAds(feed: GluedInCoreSDK.FeedModel?, genre: [String]?, dialect: [String]?, originalLanguage: [String]?, extraParams: [GluedInCoreSDK.GAMExtraParams]?, adsId: String?, adsFormatId: [String]?) {
    //
  }
  
  
}

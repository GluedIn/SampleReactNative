//
//  GADInterstitialManager.swift
//  plusSAW
//
//  Created by Ashish Verma on 09/11/21.
//  Copyright © 2021 SAW. All rights reserved.
//

import Foundation
import GoogleMobileAds
import UIKit
import AdSupport
import GluedInFeedSDK
import GluedInCoreSDK

typealias successHandlerInter = (_ didCompleted: Bool) -> ()
typealias errorHandlerInter = (_ didCompleteWithError: String) -> ()
typealias didPresentFullScreenContent = () -> ()
typealias didDismissFullScreenContent = () -> ()
typealias didFailToPresentFullScreenContentWithError = (_ didFailToPresentWithError: String) -> ()

//,
//                                GADFullScreenContentDelegate

class GADInterstitialManager: NSObject{
    
    static let shared: GADInterstitialManager = {
        let manager = GADInterstitialManager()
        return manager
    }()
    
    private var interstitial: GADInterstitialAd?
    private var presentFullScreenContent: didPresentFullScreenContent?
    private var dismissFullScreenContent: didDismissFullScreenContent?
    private var failToPresentFullScreenContentWithError : didFailToPresentFullScreenContentWithError?
    private let testDeviceID = "a2a0b4026718e03224910ada63c93bcd"
    
    func getInterstitialAdUnitID() -> String {
        return ServiceConfig.shareInstance.getInterstitialPlatformConfiguration()?.adId ?? ""
    }
    
    func initilizeAds() -> () {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    func loadInterstitialAds(didCompleted: @escaping successHandlerInter,
                             didCompleteWithError: @escaping errorHandlerInter) -> () {
#if DEBUG
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ testDeviceID ]
#endif
        let adUnitID = "ca-app-pub-3940256099942544/4411468910" //getInterstitialAdUnitID()
        GADInterstitialAd.load(withAdUnitID: adUnitID,
                               request: GADRequest(),
                               completionHandler: { [self] ad, error in
            if let error = error {
                didCompleteWithError(error.localizedDescription)
                return
            }
            interstitial = ad
//            interstitial?.fullScreenContentDelegate = self
            didCompleted(true)
        })
    }
    
    func showInterstitialAds(view: UIViewController,
                             didPresent: @escaping didPresentFullScreenContent,
                             didDismiss: @escaping didDismissFullScreenContent,
                             didFailToPresent: @escaping didFailToPresentFullScreenContentWithError) -> () {
        presentFullScreenContent = didPresent
        dismissFullScreenContent = didDismiss
        failToPresentFullScreenContentWithError = didFailToPresent
        if let ad = interstitial {
            ad.present(fromRootViewController: view)
        } else {
            print("Ads was not ready")
        }
    }
    
//    func ad(_ ad: GADFullScreenPresentingAd,
//            didFailToPresentFullScreenContentWithError error: Error) {
//        print("Ads Fail to Present")
//    }
//    
//    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        presentFullScreenContent?()
//    }
//    
//    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        dismissFullScreenContent?()
//    }
    
}




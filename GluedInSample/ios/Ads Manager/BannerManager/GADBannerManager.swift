//
//  GADBannerManager.swift
//  GluedIn
//
//  Created by Amit Choudhary on 22/08/24.
//

import Foundation
import GoogleMobileAds
import UIKit
import AdSupport
import GluedInFeedSDK
import GluedInCoreSDK

typealias successHandlerBanner = (_ didCompleted: Bool) -> ()
typealias errorHandlerBanner = (_ didCompleteWithError: String) -> ()

class GADBannerManager: NSObject {
    var bannerView: GADBannerView?

    static let shared: GADBannerManager = {
        let manager = GADBannerManager()
        return manager
    }()
    
    private var interstitial: GADInterstitialAd?
    private let testDeviceID = "a2a0b4026718e03224910ada63c93bcd"
    
    func getBannerAdUnitID() -> String {
        return ServiceConfig.shareInstance.getBannerPlatformConfiguration()?.adId ?? ""
    }
    
    func initilizeAds() -> () {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    func createRequestForBannerView(viewController: UIViewController?) -> GADBannerView? {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView?.adUnitID = "ca-app-pub-3940256099942544/2934735716"//getBannerAdUnitID()
        bannerView?.rootViewController = viewController
        //bannerView?.delegate = self
        bannerView?.load(GADRequest())
        return bannerView
    }
}

//extension GADBannerManager: GADBannerViewDelegate {
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        // Add banner to view and add constraints as above.
//        print("Banner loaded successfully")
//    }
//    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//        print("Fail to receive ads",error)
//        print(error)
//    }
//    /// Tells the delegate that a full-screen view will be presented in response
//    /// to the user clicking on an ad.
//    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
//        print("adViewWillPresentScreen")
//    }
//    /// Tells the delegate that the full-screen view will be dismissed.
//    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewWillDismissScreen")
//    }
//    /// Tells the delegate that the full-screen view has been dismissed.
//    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewDidDismissScreen")
//    }
//    /// Tells the delegate that a user click will open another app (such as
//    /// the App Store), backgrounding the current app.
//    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
//        print("adViewWillLeaveApplication")
//    }
//}




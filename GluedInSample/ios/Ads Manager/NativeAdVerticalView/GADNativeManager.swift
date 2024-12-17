import Foundation
import GoogleMobileAds
import GluedInCoreSDK
import UIKit

typealias successHandlerCustNative = (_ customNativeAd: GADCustomNativeAd) -> ()
typealias successHandlerNative = (_ nativeAd: GADNativeAd) -> ()

typealias errorHandlerNative = (_ error: String) -> ()
//GADNativeAdLoaderDelegate
class GADNativeManager: NSObject{
    
    var adLoaderDelegate: GADAdLoaderDelegate?
    var gadAdLoader: GADAdLoader?
    var adsFormatIds: [String]?
    private var completed: successHandlerCustNative?
    private var completNative: successHandlerNative?
    private var failedWithError: errorHandlerNative?
    
    override init() {
        super.init()
    }

    deinit {
        debugPrint("Deinit: GADNativeManager")
    }

    func getExtraAdditionalParameters(
        gamExtraParams: [GAMExtraParams]?,
        genre: [String]?,
        dialect: [String]?,
        originalLanguage: [String]?
    ) -> [String: String]? {
        let userDefineParameters = gamExtraParams?.reduce(into: [String: String]()) { dictionary, response in
            if let key = response.key,
               let value = response.value {
                dictionary[key] = value
            }
        }
        
        let resParams = ServiceConfig.shareInstance.getGAM()?.customParams
        let additionalParameters = resParams?.reduce(into: [String: String]()) { dictionary, response in
            if let key = response.key,
               let value = response.value,
               let type = response.type,
               type == 1 {
                dictionary[key] = value
            }
        }
        
        var genreDic: [String: String]?
        var dialectDic: [String: String]?
        var originalLanguageDic: [String: String]?
        
        if let arrGenre = genre {
            genreDic = ["genre" : arrGenre.joined(separator: " ")]
        }
        if let arrDialect = dialect {
            dialectDic = ["dialect" : arrDialect.joined(separator: " ")]
        }
        if let arrOriginalLanguage = originalLanguage {
            originalLanguageDic = ["originalLanguage" : arrOriginalLanguage.joined(separator: " ")]
        }
        
        let dictionaries: [[String: String]?] = [genreDic, dialectDic, originalLanguageDic, userDefineParameters, additionalParameters]
        
        let combinedDict = dictionaries.compactMap { $0 }.reduce([String: String]()) { (result, dict) in
            return result.merging(dict) { (_, new) in new }
        }
        return combinedDict
    }

    func loadNativeAds(
        genre: [String]?,
        dialect: [String]?,
        originalLanguage: [String]?,
        gamExtraParams: [GAMExtraParams]?,
        adUnitID: String?,
        adsFormatId: [String]?,
        didCompeleted: @escaping successHandlerCustNative,
        didFailedWithError: @escaping errorHandlerNative
    ) {
        self.completed = didCompeleted
        self.failedWithError = didFailedWithError
        self.adsFormatIds = adsFormatId
//        self.adLoaderDelegate = self
        GADMobileAds.sharedInstance().audioVideoManager.audioSessionIsApplicationManaged = true
        let videoOptions = GADVideoOptions()
        videoOptions.startMuted = true
        videoOptions.customControlsRequested = true
        
        self.gadAdLoader = GADAdLoader(
            adUnitID: "ca-app-pub-3940256099942544/2521693316", //adUnitID ?? "",
            rootViewController: nil,
            adTypes: [.customNative],
            options: [videoOptions]
        )
//        self.gadAdLoader?.delegate = self
        let request = GAMRequest()
        if let customTargetingParams = getExtraAdditionalParameters(
            gamExtraParams: gamExtraParams,
            genre: genre,
            dialect: dialect,
            originalLanguage: originalLanguage
        ) {
            request.customTargeting = customTargetingParams
        }
        self.gadAdLoader?.load(request)
    }
    
    func fetchAds(
        genre: [String]?,
        dialect: [String]?,
        originalLanguage: [String]?,
        gamExtraParams: [GAMExtraParams]?,
        adUnitID: String?,
        adsFormatId: [String]?,
        didCompeleted: @escaping successHandlerNative,
        didFailedWithError: @escaping errorHandlerNative
    ) {
        self.completNative = didCompeleted
        self.failedWithError = didFailedWithError
        self.adsFormatIds = adsFormatId
//        self.adLoaderDelegate = self
        GADMobileAds.sharedInstance().audioVideoManager.audioSessionIsApplicationManaged = true
        let videoOptions = GADVideoOptions()
        videoOptions.startMuted = true
        videoOptions.customControlsRequested = true
        
        self.gadAdLoader = GADAdLoader(
            adUnitID: "ca-app-pub-3940256099942544/1044960115",//adUnitID ?? "",
            rootViewController: nil,
            adTypes: [.customNative],
            options: [videoOptions]
        )
//        self.gadAdLoader?.delegate = self
        let request = GAMRequest()
        if let customTargetingParams = getExtraAdditionalParameters(
            gamExtraParams: gamExtraParams,
            genre: genre,
            dialect: dialect,
            originalLanguage: originalLanguage
        ) {
            request.customTargeting = customTargetingParams
        }
        self.gadAdLoader?.load(request)
    }

  @objc
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        // Handle receiving a native ad
        completNative?(nativeAd)
    }

  @objc 
  func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        failedWithError?(error.localizedDescription)
    }
    @objc
    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        self.gadAdLoader = nil
        self.adLoaderDelegate = nil
    }
}

//extension GADNativeManager: GADCustomNativeAdLoaderDelegate {
//
//    func customNativeAdFormatIDs(for adLoader: GADAdLoader) -> [String] {
//        return ["customNative","native"]
//    }
//
//    func adLoader(_ adLoader: GADAdLoader, didReceive customNativeAd: GADCustomNativeAd) {
//        completed?(customNativeAd)
//    }
//}

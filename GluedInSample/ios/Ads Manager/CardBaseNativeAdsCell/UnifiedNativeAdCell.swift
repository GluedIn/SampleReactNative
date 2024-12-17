//
//  Unifiedswift
//  GluedInSDK
//
//  Created by Shiv MacBook Pro on 05/07/22.
//

import UIKit
import GoogleMobileAds
import GluedInCoreSDK

class UnifiedNativeAdCell: UITableViewCell, GADNativeAdLoaderDelegate {
  
  private var completNative: successHandlerNative?
  private var failedWithError: errorHandlerNative?
  var gadAdLoader: GADAdLoader?
  var adLoaderDelegate: GADAdLoaderDelegate?

  func fetchAdsNative(
      adUnitID: String?,
      didCompeleted: @escaping successHandlerNative,
      didFailedWithError: @escaping errorHandlerNative
  ) {
      self.completNative = didCompeleted
      self.failedWithError = didFailedWithError
      self.adLoaderDelegate = self
      GADMobileAds.sharedInstance().audioVideoManager.audioSessionIsApplicationManaged = true
      let videoOptions = GADVideoOptions()
      videoOptions.startMuted = true
      videoOptions.customControlsRequested = true
      
      self.gadAdLoader = GADAdLoader(
          adUnitID: "ca-app-pub-3940256099942544/1044960115",//adUnitID ?? "",
          rootViewController: nil,
          adTypes: [.native],
          options: [videoOptions]
      )
      self.gadAdLoader?.delegate = self
      let request = GAMRequest()
      self.gadAdLoader?.load(request)
  }

  
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        // Handle receiving a native ad
        completNative?(nativeAd)
    }

  func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        failedWithError?(error.localizedDescription)
    }

  // Initialize adView programmatically instead of using @IBOutlet
  var adView: GADNativeAdView!
  var adUnitId: String = ""
  weak var rootViewController: UIViewController?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupAdView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupAdView()
  }
  
  private func setupAdView() {
    // Initialize adView
    adView = GADNativeAdView()
    adView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(adView)
    
    // Configure Auto Layout constraints for adView
    NSLayoutConstraint.activate([
      adView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      adView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      adView.topAnchor.constraint(equalTo: contentView.topAnchor),
      adView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
    
    // Additional subviews configuration (callToActionView, iconView, etc.)
    configureAdSubviews()
  }
  
  private func configureAdSubviews() {
    // Configure callToActionView
    let callToActionView = UIButton()
    callToActionView.layer.cornerRadius = 20
    callToActionView.setTitleColor(.white, for: .normal)
    callToActionView.backgroundColor = .blue
    callToActionView.translatesAutoresizingMaskIntoConstraints = false
    adView.callToActionView = callToActionView
    adView.addSubview(callToActionView)
    
    // Set constraints for callToActionView
    NSLayoutConstraint.activate([
      callToActionView.centerXAnchor.constraint(equalTo: adView.centerXAnchor),
      callToActionView.bottomAnchor.constraint(equalTo: adView.bottomAnchor, constant: -5),
      callToActionView.heightAnchor.constraint(equalToConstant: 40),
      callToActionView.widthAnchor.constraint(equalToConstant: 280)
    ])
    
    // Configure iconView
    let iconView = UIImageView()
    iconView.layer.cornerRadius = 10
    iconView.layer.borderColor = UIColor.white.cgColor
    iconView.layer.borderWidth = 1
    iconView.translatesAutoresizingMaskIntoConstraints = false
    adView.iconView = iconView
    adView.addSubview(iconView)
    
    // Set constraints for iconView
    NSLayoutConstraint.activate([
      iconView.leadingAnchor.constraint(equalTo: adView.leadingAnchor, constant: 10),
      iconView.topAnchor.constraint(equalTo: adView.topAnchor, constant: 10),
      iconView.widthAnchor.constraint(equalToConstant: 40),
      iconView.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    // Configure mediaView
    let mediaView = GADMediaView()
    mediaView.contentMode = .scaleAspectFit
    mediaView.translatesAutoresizingMaskIntoConstraints = false
    adView.mediaView = mediaView
    adView.addSubview(mediaView)
    
    // Set constraints for mediaView
    NSLayoutConstraint.activate([
      mediaView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
      mediaView.trailingAnchor.constraint(equalTo: adView.trailingAnchor, constant: -10),
      mediaView.topAnchor.constraint(equalTo: adView.topAnchor, constant: 10),
      mediaView.heightAnchor.constraint(equalToConstant: 100)
    ])
    
    updateUI()
  }
  
  func configure(withNativeAd nativeAd: GADNativeAd?) {
    guard let nativeAd = nativeAd else { return }
    
    adView.nativeAd = nativeAd
    adView.mediaView?.mediaContent = nativeAd.mediaContent
    
    (adView.headlineView as? UILabel)?.text = nativeAd.headline
    adView.headlineView?.isHidden = nativeAd.headline == nil
    
    (adView.bodyView as? UILabel)?.text = nativeAd.body
    adView.bodyView?.isHidden = nativeAd.body == nil
    
    (adView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
    adView.callToActionView?.isHidden = nativeAd.callToAction == nil
    adView.callToActionView?.isUserInteractionEnabled = false
    
    (adView.iconView as? UIImageView)?.image = nativeAd.icon?.image
    adView.iconView?.isHidden = nativeAd.icon == nil
  }
  
  func nativeAdsLoader(
    requiredNumberOfAds: Int,
    gadNativeAd: @escaping (_ nativeAd: GADNativeAd?) -> ()
  ) -> () {
    GADNativeManager().fetchAds(
      genre: nil,
      dialect: nil,
      originalLanguage: nil,
      gamExtraParams: nil,
      adUnitID: "ca-app-pub-3940256099942544/3986624511", //adUnitId,
      adsFormatId: ["banner"]) { nativeAd in
        gadNativeAd(nativeAd)
      } didFailedWithError: { error in
        debugPrint("didCompleteWithError \(error)")
      }
  }
  
  func updateUI() {
    fetchAdsNative(
      adUnitID: adUnitId) { [weak self] nativeAd in
        //                gadNativeAd(nativeAd)
        guard let weakSelf = self else { return }
        nativeAd.rootViewController = weakSelf.rootViewController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          weakSelf.adView?.nativeAd = nativeAd
          weakSelf.adView?.mediaView?.mediaContent = nativeAd.mediaContent
        }
        
        DispatchQueue.main.async {
          if let mediaView = weakSelf.adView?.mediaView,
             nativeAd.mediaContent.aspectRatio > 0 {
            let heightConstraint = NSLayoutConstraint(
              item: mediaView,
              attribute: .height,
              relatedBy: .equal,
              toItem: mediaView,
              attribute: .width,
              multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
              constant: 0)
            heightConstraint.isActive = true
          }
        }
        
        (weakSelf.adView?.headlineView as? UILabel)?.text = nativeAd.headline
        weakSelf.adView?.headlineView?.isHidden = nativeAd.headline == nil
        
        (weakSelf.adView?.bodyView as? UILabel)?.text = nativeAd.body
        weakSelf.adView?.bodyView?.isHidden = nativeAd.body == nil
        
        (weakSelf.adView?.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        weakSelf.adView?.callToActionView?.isHidden = nativeAd.callToAction == nil
        weakSelf.adView?.callToActionView?.isUserInteractionEnabled = false
        
        (weakSelf.adView?.iconView as? UIImageView)?.image = nativeAd.icon?.image
        weakSelf.adView?.iconView?.isHidden = nativeAd.icon == nil
        
      } didFailedWithError: { error in
        debugPrint("didCompleteWithError \(error)")
      }
  }
}

//
//  GameViewController.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import UIKit
import SpriteKit
import GoogleMobileAds
import Combine

class GameViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var gameView: SKView!
    private var subscription: AnyCancellable?
    private var rewardedAd: GADRewardedAd?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    override var prefersStatusBarHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName = Notification.Name("fullscreen")
        NotificationCenter.default.addObserver(self, selector: #selector(loadRewardedAd), name: notificationName, object: nil)
      GameKitController.shared.setUp()
        subscription = PurchaseController.shared.$isPurchased.sink(receiveValue: { [self] isPurchased in
            if isPurchased {
              self.constrainForFullscreen()
            } else {
                bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
                bannerView.rootViewController = self
                bannerView.load(GADRequest())
            }
        })

        
        let scene = SKScene(fileNamed: "MainScene")
        scene?.scaleMode = .aspectFit
        gameView.ignoresSiblingOrder = true
        gameView.presentScene(scene)
    }
  
  @objc func constrainForFullscreen() {
    UIView.animate(withDuration: 0.5) {
      self.adView.removeFromSuperview()
      NSLayoutConstraint.activate([
        self.gameView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
      ])
    }
  }
}
extension GameViewController: GADFullScreenContentDelegate {
    
      @objc func loadRewardedAd() {
      let request = GADRequest()
      GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
                         request: request,
                         completionHandler: { [self] ad, error in
        if let error = error {
          print("Failed to load rewarded ad with error: \(error.localizedDescription)")
          return
        }
        rewardedAd = ad
        print("Rewarded ad loaded.")
          rewardedAd?.fullScreenContentDelegate = self
          self.showFullscreenAd()
      }
      )
    }
       func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
         print("Ad did fail to present full screen content.")
       }

       func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
         print("Ad will present full screen content.")
       }

       func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
         constrainForFullscreen()
       }
      
    
    func showFullscreenAd() {
        if let ad = rewardedAd {
          ad.present(fromRootViewController: self) {
            let reward = ad.adReward
            print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
              
              // Add a reward for the user here
          }
        } else {
          print("Ad wasn't ready")
        }
      }
}

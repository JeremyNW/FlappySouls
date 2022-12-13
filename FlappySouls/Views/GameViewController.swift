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
import GameKit

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
        
        // Notifications
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(presentFullscreenAlert), name: .init("fullscreen"), object: nil)
        nc.addObserver(self, selector: #selector(presentInfoPopup), name: .init("Info"), object: nil)
        nc.addObserver(self, selector: #selector(purchaseComplete), name: .init("purchase"), object: nil)
        
        
        let fullscreenNc = NotificationCenter.default
        fullscreenNc.addObserver(self, selector: #selector(presentFullscreenAlert), name: .init("alert"), object: nil)
        
        // GameKit
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.isActive = true
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            error?.log()
            if let viewController {
                self.present(viewController, animated: true)
            }
        }
        
        // Monetization
        if Persistence.shared.getBool(.isPurchased) {
            self.constrainForFullscreen()
        } else {
            bannerView.adUnitID = Advertisement.bannerID
            bannerView.rootViewController = self
            bannerView.load(Advertisement.request)
        }
        
        // Game Start
        presentMainScene()
    }
    
    @objc func purchaseComplete() {
        Persistence.shared.setBool(.isPurchased, value: true)
        constrainForFullscreen()
        presentMainScene()
    }
    
    @objc func constrainForFullscreen() {
        GameState.isFullscreen = true
        UIView.animate(withDuration: 0.5) {
            self.adView.removeFromSuperview()
            NSLayoutConstraint.activate([
                self.gameView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        presentMainScene()
    }
    
    @objc func presentFullscreenAlert() {
        
        let alert = UIAlertController(title: "Rewarded Ad", message: "Watch a brief ad to unlock fullscreen?", preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        let watchButton = UIAlertAction(title: "Watch", style: .default) { _ in
            self.loadRewardedAd()
            let notificationName = Notification.Name("Waiting")
            let notification = Notification(name: notificationName)
            NotificationCenter.default.post(notification)
        }
        alert.addAction(cancelButton)
        alert.addAction(watchButton)
        
        present(alert, animated: true)
    }
    
    @objc func presentInfoPopup() {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        guard let info = storyboard.instantiateInitialViewController() else { return }
        present(info, animated: true)
    }
    
    func presentMainScene() {
        let scene = SKScene(fileNamed: "MainScene")
        scene?.scaleMode = .aspectFit
        gameView.ignoresSiblingOrder = true
        gameView.presentScene(scene)
    }
}
extension GameViewController: GADFullScreenContentDelegate {
    @objc func loadRewardedAd() {
        GADRewardedAd
            .load(
                withAdUnitID:Advertisement.rewardedID,
                request: Advertisement.request
            ){ [self] ad, error in
                error?.log()
                rewardedAd = ad
                rewardedAd?.fullScreenContentDelegate = self
                ad?.present(fromRootViewController: self) {
                    self.constrainForFullscreen()
                }
            }
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        error.log()
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {}
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {}
}

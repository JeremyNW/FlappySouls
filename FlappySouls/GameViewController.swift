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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    override var prefersStatusBarHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      GameKitController.shared.setUp()
        subscription = PurchaseController.shared.$isPurchased.sink(receiveValue: { [self] isPurchased in
            if isPurchased {
                adView.removeFromSuperview()
                NSLayoutConstraint.activate([
                    gameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
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
}

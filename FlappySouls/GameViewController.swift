//
//  GameViewController.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var gameView: SKView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    override var prefersStatusBarHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
      bannerView.rootViewController = self
      bannerView.load(GADRequest())
      
      let scene = SKScene(fileNamed: "MainScene")
      scene?.scaleMode = .aspectFit
      gameView.ignoresSiblingOrder = true
      gameView.presentScene(scene)
    }
}

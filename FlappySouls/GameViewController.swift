//
//  GameViewController.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var gameView: SKView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    override var prefersStatusBarHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = gameView {
            if let scene = SKScene(fileNamed: "MainScene") {
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
    }
}

//
//  GameObject.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/21/22.
//

import Foundation
import SpriteKit

protocol GameObject {
    func setUp(for state: GameState)
    func update(_ currentTime: TimeInterval)
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func didCollide(with node: SKNode?)
}

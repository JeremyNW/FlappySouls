//
//  GameState.swift
//  FlappySouls
//
//  Created by Jared Warren on 11/28/22.
//

import Foundation

class GameState {
    var score = 0 {
        didSet { currency += 1 }
    }
    var waves = 0 {
        didSet { currency += 1 }
    }
    private(set) var currency = 0
}

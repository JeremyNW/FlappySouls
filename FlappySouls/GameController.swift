//
//  GameController.swift
//  FlappySouls
//
//  Created by Jared Warren on 11/28/22.
//

import Foundation

class GameController {
  var gameState = GameState.playing
  var score = 0
}

enum GameState {
  case mainMenu
  case playing
  case gameOverMenu
}

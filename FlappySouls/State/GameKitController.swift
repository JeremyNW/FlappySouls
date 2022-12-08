//
//  GameKitController.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/7/22.
//

import Foundation
import GameKit

class GameKitController {
  static let shared = GameKitController()
  private let leaderboardIDs = ["Eternal", "Ephemeral"]
  private init(){}
  
  func setUp() {
    GKAccessPoint.shared.location = .topLeading
    GKAccessPoint.shared.showHighlights = true
    GKAccessPoint.shared.isActive = true
  }
  
  func submitScore(_ score: Int) {
    GKLeaderboard
      .submitScore(
      score,
      context: 0,
      player: GKLocalPlayer.local,
      leaderboardIDs: leaderboardIDs) { error in
        if let error {
          print(error, error.localizedDescription)
        }
        // TODO: if error, save the hiscore to user defaults and try again later
      }
  }
}

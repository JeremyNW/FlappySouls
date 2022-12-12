//
//  Leaderboards.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/11/22.
//

import Foundation
import GameKit

class Leaderboards {
  static let shared = Leaderboards()
  private let ids = ["Eternal", "Ephemeral"]
  private init() {}
  
  func report(_ score: Int) {
    guard GKLocalPlayer.local.isAuthenticated else { return }
    GKLeaderboard
      .submitScore(
      score,
      context: 0,
      player: GKLocalPlayer.local,
      leaderboardIDs: ids) { error in
        error?.log()
      }
  }
  
  func load() {
    guard GKLocalPlayer.local.isAuthenticated else { return }
    GKLeaderboard
      .loadLeaderboards(IDs: ids) { leaderboards, error in
        error?.log()
        if let eternal = leaderboards?.first {
          eternal.loadEntries(for: [GKLocalPlayer.local], timeScope: .allTime) { entry, _, error in
            error?.log()
            if let entry,
               entry.rank <= 100 {
              let achievement = GKAchievement(identifier: "eternal")
              achievement.percentComplete = 100
              achievement.showsCompletionBanner = true
              GKAchievement.report([achievement])
            }
          }
        }
        if let ephemeral = leaderboards?.last {
          ephemeral.loadEntries(for: [GKLocalPlayer.local], timeScope: .allTime) { entry, _, error in
            error?.log()
            if let entry,
               entry.rank == 1 {
              let achievement = GKAchievement(identifier: "ephemeral")
              achievement.percentComplete = 100
              achievement.showsCompletionBanner = true
              GKAchievement.report([achievement])
            }
          }
        }
      }
  }
}

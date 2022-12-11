//
//  Persistence.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/11/22.
//

import Foundation

class Persistence {
  static let shared = Persistence()
  private let storage = UserDefaults.standard
  private init() {}
  
  func getBool(_ key: PersistedBool) -> Bool {
    storage.bool(forKey: key.rawValue)
  }
  
  func setBool(_ key: PersistedBool, value: Bool) {
    storage.set(value, forKey: key.rawValue)
  }
  
  func getInteger(_ key: PersistedInteger) -> Int {
    storage.integer(forKey: key.rawValue)
  }
  
  func incrementInteger(_ key: PersistedInteger, additionalValue: Int) {
    let total = getInteger(key) + additionalValue
    storage.set(total, forKey: key.rawValue)
  }
  
  
  enum PersistedBool: String {
    case isPurchased
  }
  
  enum PersistedInteger: String {
    case attackedWithSword
    case slainEyes
    case slainTeeth
    case slainArmor
    case slainWithShield
  }
}

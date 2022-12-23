//
//  Haptics.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/22/22.
//

import Foundation
import UIKit

class Haptics {
  private static let soft: UIImpactFeedbackGenerator = {
    let generator = UIImpactFeedbackGenerator(style: .soft)
    generator.prepare()
    return generator
  }()
  private static let heavy: UIImpactFeedbackGenerator = {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.prepare()
    return generator
  }()
  private static let rigid: UIImpactFeedbackGenerator = {
    let generator = UIImpactFeedbackGenerator(style: .rigid)
    generator.prepare()
    return generator
  }()
  
  static func sendFeedback(_ type: HapticType) {
    switch type {
    case .soft:
      soft.impactOccurred(intensity: 1)
    case .heavy:
      heavy.impactOccurred(intensity: 1)
    case .rigid:
      rigid.impactOccurred(intensity: 1)
    }
  }
  
  enum HapticType {
    case soft, heavy, rigid
  }
}

//
//  Advertisement.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/11/22.
//

import Foundation
import GoogleMobileAds

enum Advertisement {
#if DEBUG
  static let bannerID = "ca-app-pub-3940256099942544/2934735716"
  static let rewardedID = "ca-app-pub-3940256099942544/1712485313"
#else
  static let bannerID = "ca-app-pub-8396290292926383/8584738508"
  static let rewardedID = "ca-app-pub-8396290292926383/3310276810"
#endif
  static var request: GADRequest {
    let request = GADRequest()
    request.keywords = ["game", "gaming", "games", "gamer"]
    return request
  }
}

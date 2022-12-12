//
//  Error+Extension.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/11/22.
//

import Foundation

extension Error {
  func log() {
    #if DEBUG
    print(self, self.localizedDescription)
    #endif
  }
}

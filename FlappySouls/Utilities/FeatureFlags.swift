//
//  FeatureFlags.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/22/22.
//

import Foundation

/**
 Hide features that are still a work in progress.
 All flags should be manually set to `true` during develoment.
 All flags should be manually set to `false` when we push updates to the store
 */
enum FeatureFlags {
    #if DEBUG
    static let isBossModeEnabled = true
    #else
    static let isBossModeEnabled = false
    #endif
}

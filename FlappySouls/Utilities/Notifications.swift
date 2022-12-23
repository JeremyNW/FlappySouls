//
//  Notifications.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/22/22.
//

import Foundation
import NotificationCenter

enum GameNotification: String {
    case fullscreen
    case info
    case purchase
    case waiting
    
    private static let nc = NotificationCenter.default
    
    static func post(_ gameNotification: GameNotification) {
        let name = Notification.Name(gameNotification.rawValue)
        let notification = Notification(name: name)
        nc.post(notification)
    }
    
    static func addObserver(_ observer: AnyObject, notification: GameNotification, selector: Selector) {
        let name = Notification.Name(notification.rawValue)
        nc.addObserver(
            observer,
            selector: selector,
            name: name,
            object: nil
        )
    }
}

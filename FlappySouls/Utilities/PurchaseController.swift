//
//  PurchaseController.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/6/22.
//

import Foundation
import StoreKit

class PurchaseController: NSObject, SKPaymentTransactionObserver, ObservableObject {
    
    static let shared = PurchaseController()
    let productID = "com.macrinallc.flappyjudgement.fullscreen"
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }

    
    func buyFullscreen() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("user cannot make payments")
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                let notificationName = Notification.Name("purchase")
                let notification = Notification(name: notificationName)
                NotificationCenter.default.post(notification)
                
            } else if transaction.transactionState == .failed {
                print("transaction failed")
            }
        }
        
    }
    
}

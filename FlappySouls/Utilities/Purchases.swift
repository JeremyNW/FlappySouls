//
//  Purchases.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/6/22.
//

import Foundation
import StoreKit

class Purchases: NSObject, SKPaymentTransactionObserver, ObservableObject {
    static let shared = Purchases()
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
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                GameNotification.post(.purchase)
            }
        }
    }
}

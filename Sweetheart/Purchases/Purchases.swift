//
//  Purchases.swift
//  Sweetheart
//
//  Created by anmin on 02.02.2021.
//

import Foundation
import StoreKit

typealias RequestProductsResult = Result<[SKProduct], Error>
typealias PurchaseProductResult = Result<Bool, Error>

typealias RequestProductsCompletion = (RequestProductsResult) -> Void
typealias PurchaseProductCompletion = (PurchaseProductResult) -> Void

class Purchases: NSObject {
    static let shared = Purchases()
    
    private let productIdentifiers = Set<String>(
        arrayLiteral: "hopeTo.Sweetheart.five", "hopeTo.Sweetheart.trwentytwo", "hopeTo.Sweetheart.crazy" , "hopeTo.Sweetheart.fifty", "hopeTo.Sweetheart.hundreed", "hopeTo.Sweetheart.twoFifty", "hopeTo.Sweetheart.oneFiveZeroZero"
    )
    
    private var products: [String: SKProduct]?
    private var productRequest: SKProductsRequest?
    
    func initialize(completion: @escaping RequestProductsCompletion) {
        SKPaymentQueue.default().add(self)
        requestProducts(completion: completion)
    }
    
    private var productsRequestCallbacks = [RequestProductsCompletion]()
    
    private func requestProducts(completion: @escaping RequestProductsCompletion) {
        guard productsRequestCallbacks.isEmpty else {
            productsRequestCallbacks.append(completion)
            return
        }
        
        productsRequestCallbacks.append(completion)
        
        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()
        
        self.productRequest = productRequest
    }
    
    fileprivate var productPurchaseCallback: ((PurchaseProductResult) -> Void)?

   func purchaseProduct(productId: String, completion: @escaping (PurchaseProductResult) -> Void) {
       // 1:
       guard productPurchaseCallback == nil else {
           completion(.failure(PurchasesError.purchaseInProgress))
           return
       }
       // 2:
       guard let product = products?[productId] else {
           completion(.failure(PurchasesError.productNotFound))
           return
       }

       productPurchaseCallback = completion

       // 3:
       let payment = SKPayment(product: product)
       SKPaymentQueue.default().add(payment)
   }

}

extension Purchases: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard !response.products.isEmpty else {
            print("Found 0 products")
            
            productsRequestCallbacks.forEach { $0(.success(response.products)) }
            productsRequestCallbacks.removeAll()
            return
        }
        
        var products = [String: SKProduct]()
        for skProduct in response.products {
            print("Found product: \(skProduct.productIdentifier)")
            products[skProduct.productIdentifier] = skProduct
        }
        
        self.products = products
        
        productsRequestCallbacks.forEach { $0(.success(response.products)) }
        productsRequestCallbacks.removeAll()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load products with error:\n \(error)")
        
        productsRequestCallbacks.forEach { $0(.failure(error)) }
        productsRequestCallbacks.removeAll()
    }
}

extension Purchases: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // 1:
        for transaction in transactions {
            switch transaction.transactionState {
            // 2:
            case .purchased, .restored:
                if finishTransaction(transaction) {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    productPurchaseCallback?(.success(true))
                    
                } else {
                    productPurchaseCallback?(.failure(PurchasesError.unknown))
                }
            // 3:
            case .failed:
                productPurchaseCallback?(.failure(transaction.error ?? PurchasesError.unknown))
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
}

extension Purchases {
    // 4:
    func finishTransaction(_ transaction: SKPaymentTransaction) -> Bool {
        let productId = transaction.payment.productIdentifier
        print("Product \(productId) successfully purchased")
        return true
    }
}

enum PurchasesError: Error {
    case purchaseInProgress
    case productNotFound
    case unknown
}


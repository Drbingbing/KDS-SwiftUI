//
//  SampleData.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//
import Foundation

struct SampleData {
    
    private static var lastOrderID: UInt32 = 10000000
    
    static func randomOrder(_ itemsCount: Int) -> [NewOrder] {
        let orderId = lastOrderID + 1
        let tag = generateRandomTag()
        let items = (0..<itemsCount).map { _ in
            NewOrderItem(
                itemID: generateRandomNumber(6),
                orderID: orderId,
                name: generateRandomProductName(),
                quantity: generateRandomQuantity()
            )
        }
        
        lastOrderID = orderId
        return [NewOrder(orderID: orderId, tag: tag, orderItems: items)]
    }
}

private func generateRandomTag() -> String {
    
    func randomUppercaseLetter() -> Character {
        let letters = (65...90).compactMap { UnicodeScalar($0) }
        return Character(letters.randomElement()!)
    }
    
    let alphabet = randomUppercaseLetter()
    let number = generateRandomNumber(1)
    
    return String(alphabet) + String(number)
}

private func generateRandomQuantity() -> UInt32 {
    return generateRandomNumber(1)
}

private func generateRandomProductName() -> String {
    let availableProducts = ["Pizza", "Pasta", "Salad", "Coca", "Watermelon", "Coffee", "Noodle"]
    return availableProducts.randomElement()!
}

private func generateRandomNumber(_ numDigits: Int) -> UInt32 {
    var place: UInt32 = 1
    var finalNumber: UInt32 = 0
    for _ in 0..<numDigits {
        place *= 10
        let randomNumber = arc4random_uniform(10)
        finalNumber += randomNumber * place
    }
    return finalNumber
}

//
//private func generateRandomNumber(_ numDigits: Int) {
//    var place = 1
//    var finalNumber = 0;
//    for(int i = 0; i < numDigits; i++){
//        place *= 10
//        var randomNumber = arc4random_uniform(10)
//        finalNumber += randomNumber * place
//    }
//    return finalNumber
//}

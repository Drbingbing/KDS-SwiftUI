//
//  Order.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import Foundation

public struct OrderItem: Hashable, Sendable, Identifiable {
    
    public var id: UInt32 { itemID }
    
    public var state: OrderItemState
    public let itemID: UInt32
    public let orderID: UInt32
    public let name: String
    public let quantity: UInt32
    
    public init(itemID: UInt32, orderID: UInt32, name: String, quantity: UInt32, state: OrderItemState) {
        self.itemID = itemID
        self.orderID = orderID
        self.name = name
        self.quantity = quantity
        self.state = state
    }
}

public struct Order: Sendable, Hashable, Identifiable {
    
    public var id: UInt32 { orderID }
    
    public let orderID: UInt32
    public let orderNumber: String
    public let diningOption: DiningOption
    public let numberOfDiners: Int
    public var items: [OrderItem]
    
    public init(orderID: UInt32, orderNumber: String, diningOption: String, numberOfDiners: Int, items: [OrderItem]) {
        self.orderID = orderID
        self.orderNumber = orderNumber
        self.diningOption = DiningOption(diningOption) ?? .takeout
        self.numberOfDiners = numberOfDiners
        self.items = items
    }
}

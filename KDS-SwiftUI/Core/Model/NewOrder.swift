//
//  NewOrder.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

public struct NewOrder: Sendable, Hashable {
    public let orderID: UInt32
    public let tag: String
    public let orderItems: [NewOrderItem]
    
    public init(orderID: UInt32, tag: String, orderItems: [NewOrderItem]) {
        self.orderID = orderID
        self.tag = tag
        self.orderItems = orderItems
    }
}

public struct NewOrderItem: Sendable, Hashable {
    public let itemID: UInt32
    public let orderID: UInt32
    public let name: String
    public let quantity: UInt32
    
    public init(itemID: UInt32, orderID: UInt32, name: String, quantity: UInt32) {
        self.itemID = itemID
        self.orderID = orderID
        self.name = name
        self.quantity = quantity
    }
}

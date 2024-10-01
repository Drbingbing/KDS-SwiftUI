//
//  NewOrder.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

public struct NewOrder: Sendable, Hashable {
    public let orderID: Int
    public let tag: String
    public let orderItems: [NewOrderItem]
    
    public init(orderID: Int, tag: String, orderItems: [NewOrderItem]) {
        self.orderID = orderID
        self.tag = tag
        self.orderItems = orderItems
    }
}

public struct NewOrderItem: Sendable, Hashable {
    public let itemID: Int
    public let orderID: Int
    public let name: String
    public let quantity: Int
    
    public init(itemID: Int, orderID: Int, name: String, quantity: Int) {
        self.itemID = itemID
        self.orderID = orderID
        self.name = name
        self.quantity = quantity
    }
}

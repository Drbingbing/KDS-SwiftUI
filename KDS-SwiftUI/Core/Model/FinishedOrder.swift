//
//  FinishedOrder.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//


import Foundation

public struct FinishedOrderItem: Sendable, Hashable {
    
    public let itemID: UInt32
    public let completeDate: Date
    public let quantity: UInt32
        
    public init(itemID: UInt32, completeDate: Date, quantity: UInt32) {
        self.itemID = itemID
        self.completeDate = completeDate
        self.quantity = quantity
    }
}

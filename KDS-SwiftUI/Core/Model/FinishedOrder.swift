//
//  FinishedOrder.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//


import Foundation

public struct FinishedOrderItem {
    
    public let itemID: Int
    public let completeDate: Date
    public let quantity: Int
        
    public init(itemID: Int, completeDate: Date, quantity: Int) {
        self.itemID = itemID
        self.completeDate = completeDate
        self.quantity = quantity
    }
}

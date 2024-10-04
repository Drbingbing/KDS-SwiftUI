//
//  CancelledOrder.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import Foundation

public struct CancelledOrderItem: Sendable, Hashable {
    
    public let itemID: UInt32
    public let cancelledDate: Date
        
    public init(itemID: UInt32, cancelledDate: Date) {
        self.itemID = itemID
        self.cancelledDate = cancelledDate
    }
}

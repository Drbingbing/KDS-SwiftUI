//
//  OrderItemState.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import Foundation

public enum OrderItemState: Sendable, Hashable {
    case finished(Date)
    case cancelled(Date)
    case new
    
    var isCancelled: Bool {
        if case .cancelled = self {
            return true
        }
        return false
    }
    
    var isFinished: Bool {
        if case .finished = self {
            return true
        }
        return false
    }
    
    var isNew: Bool {
        if case .new = self {
            return true
        }
        return false
    }
}

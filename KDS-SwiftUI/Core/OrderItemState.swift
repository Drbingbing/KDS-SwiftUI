//
//  OrderItemState.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import Foundation

public enum OrderItemState: Sendable, Hashable {
    case finished(Date)
    case new
}

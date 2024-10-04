//
//  DiningOption.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

public enum DiningOption: Hashable, Sendable {
    case dineIn
    case takeout
    case delivery
    
    init?(_ rawValue: String) {
        switch rawValue {
        case "dine-in":
            self = .dineIn
        case "takeout", "to-go":
            self = .takeout
        case "delivery":
            self = .delivery
        default:
            return nil
        }
    }
}

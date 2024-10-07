//
//  ProcessingState.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/7.
//

import Foundation

public enum ProcessingState: Sendable, Hashable {
    case complete
    case cancel
    case process(TimeInterval)
}

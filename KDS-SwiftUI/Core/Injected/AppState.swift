//
//  AppState.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import Foundation

final class AppState: ObservableObject {
    @Published var currentTime: String = ""
    @Published var allOrders: [Order] = []
}

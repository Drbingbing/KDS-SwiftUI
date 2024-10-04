//
//  KDS_SwiftUIApp.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import SwiftUI

@main
struct KDS_SwiftUIApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            MainWindow()
                .environmentObject(appState)
        }
    }
}

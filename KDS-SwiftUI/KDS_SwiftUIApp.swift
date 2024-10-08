//
//  KDS_SwiftUIApp.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import SwiftUI

@main
struct KDS_SwiftUIApp: App {
    
    @StateObject var appState: AppState = AppState()
    lazy var appEnvironment: AppEnvironment = AppEnvironment.bootstrap(appState)
    
    var body: some Scene {
        WindowGroup {
            MainWindow()
                .environment(\.appEnvironment, .bootstrap(appState))
                .environmentObject(appState)
                .onAppear {
                    appState.currentTime = Current.date().formatted(date: .omitted, time: .shortened)
                }
        }
    }
}

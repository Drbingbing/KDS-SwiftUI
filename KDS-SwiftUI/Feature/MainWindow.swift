//
//  MainWindow.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct MainWindow: View {
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment: AppEnvironment
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                switch appState.displayStyle {
                case .grid:
                    OrderGridView()
                case .list:
                    KitchenHeader()
                    OrderListView()
                }
                Spacer()
            }
            .mainToolbar()
            .navigationTitle(
                Text(appState.currentTime)
            )
        }
    }
}


#Preview {
    let appState = AppState()
    let appEnvironment = AppEnvironment.bootstrap(appState)
    MainWindow()
        .environment(\.appEnvironment, appEnvironment)
        .environmentObject(appState)
        .onAppear {
            appState.currentTime = appEnvironment.current.date().formatted(date: .omitted, time: .shortened)
        }
}

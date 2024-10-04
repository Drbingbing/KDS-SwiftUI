//
//  MainWindow.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct MainWindow: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                KitchenHeader()
                OrderListView()
            }
            .mainToolbar()
            .navigationTitle(
                Text(appState.currentTime)
            )
        }
    }
}


#Preview {
    MainWindow()
        .environmentObject(AppState())
}

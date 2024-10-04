//
//  MainToolbar.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct MainToolbarModifier: ViewModifier {
    
    @EnvironmentObject var appState: AppState
    
    func body(content: Content) -> some View {
        content
            .toolbar { toolbar }
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup {
            Button(action: {
                withAnimation { appState.makeNewOrder() }
            }) {
                Image(systemName: "plus")
                    .foregroundStyle(.black)
            }
        }
    }
}

extension View {
    func mainToolbar() -> some View {
        modifier(
            MainToolbarModifier()
        )
    }
}

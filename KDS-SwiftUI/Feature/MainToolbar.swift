//
//  MainToolbar.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct MainToolbarModifier: ViewModifier {
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment: AppEnvironment
    @EnvironmentObject var appState: AppState
    
    func body(content: Content) -> some View {
        content
            .toolbar { toolbar }
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup {
            Button(action: {
                withAnimation { appEnvironment.interactors.displayInteractor.toggle() }
            }) {
                switch appState.displayStyle {
                case .grid:
                    Image(systemName: "list.bullet")
                        .foregroundStyle(.black)
                case .list:
                    Image(systemName: "rectangle.grid.2x2")
                        .foregroundStyle(.black)
                }
            }
            Button(action: {
                withAnimation { appEnvironment.interactors.orderInteractor.makeNewOrder() }
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

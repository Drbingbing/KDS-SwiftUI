//
//  DisplayStyle.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/8.
//

protocol DisplayStyleInteractor {
    func changeDisplay(to newStyle: DisplayStyle)
    func toggle()
}

struct DisplayStyleInteractorImpl: DisplayStyleInteractor {
    
    let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func changeDisplay(to newStyle: DisplayStyle) {
        appState.displayStyle = newStyle
    }
    
    func toggle() {
        switch appState.displayStyle {
        case .grid:
            appState.displayStyle = .list
        case .list:
            appState.displayStyle = .grid
        }
    }
}

struct StubDisplayStyleInteractor: DisplayStyleInteractor {
    func changeDisplay(to newStyle: DisplayStyle) {}
    func toggle() {}
}

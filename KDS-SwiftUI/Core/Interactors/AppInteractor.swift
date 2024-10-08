//
//  AppInteractor.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/8.
//

protocol AppInteractor {
    func updateTime()
}

struct AppInteractorImpl: AppInteractor {
    
    let appState: AppState
    let environment: Environment
    
    func updateTime() {
        appState.currentTime = environment.date().formatted(date: .omitted, time: .shortened)
    }
}

struct StubAppInteractor: AppInteractor {
    func updateTime() {}
}

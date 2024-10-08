//
//  AppEnvironment.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/7.
//

import Combine
import SwiftUI

struct AppEnvironment {
    let interactors: Interactors
    let current: Environment
    
    init(interactors: Interactors, environment: Environment = Current) {
        self.interactors = interactors
        self.current = environment
    }
}

extension AppEnvironment {
    static func bootstrap(_ appState: AppState) -> AppEnvironment {
        let orderInteractor = OrderInteractorImpl(appState: appState)
        let displayStyleInteractor = DisplayStyleInteractorImpl(appState: appState)
        let interactors = Interactors(orderInteractor: orderInteractor, displayInteractor: displayStyleInteractor)
        return AppEnvironment(interactors: interactors)
    }
}

extension AppEnvironment: EnvironmentKey {
    
    static var defaultValue: AppEnvironment = Self(interactors: .stub, environment: Environment())
}

extension EnvironmentValues {
    var appEnvironment: AppEnvironment {
        get { self[AppEnvironment.self] }
        set { self[AppEnvironment.self] = newValue }
    }
}

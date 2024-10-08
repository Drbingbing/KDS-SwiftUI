//
//  Interactors.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/7.
//

struct Interactors {
    let orderInteractor: any OrderInteractor
    let displayInteractor: any DisplayStyleInteractor
    
    static var stub: Self {
        .init(orderInteractor: StubOrderInteractor(), displayInteractor: StubDisplayStyleInteractor())
    }
}

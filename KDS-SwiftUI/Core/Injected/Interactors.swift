//
//  Interactors.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/7.
//

struct Interactors {
    let orderInteractor: any OrderInteractor
    
    static var stub: Self {
        .init(orderInteractor: StubOrderInteractor())
    }
}

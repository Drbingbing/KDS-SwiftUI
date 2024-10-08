//
//  Buttons.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct MarkAsCancelButton: View {
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment
    
    let appState: AppState
    var orderItem: OrderItem
    
    var body: some View {
        Button(action: cancel) {
            Text("Mark as cancel")
        }
    }
    
    private func cancel() {
        appEnvironment.interactors.orderInteractor.orderItemCancelled(in: orderItem.orderID, itemID: orderItem.itemID)
    }
}

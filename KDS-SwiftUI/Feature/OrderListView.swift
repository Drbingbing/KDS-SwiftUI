//
//  OrderListView.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var appState: AppState
    
    var visibleOrders: [Order] {
        appState.allOrders.filter {
            var isClosed = true
            if $0.items.contains(where: { $0.state.isCancelled || $0.state.isNew }) {
                isClosed = false
            }
            return !isClosed
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(visibleOrders) { order in
                OrderSection(order: order, appState: appState)
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear(perform: appState.makeNewOrder)
    }
}

//
//  OrderListView.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            ForEach(appState.allOrders) { order in
                OrderSection(order: order, appState: appState)
            }
        }
        .listStyle(.insetGrouped)
        .onAppear(perform: appState.makeNewOrder)
    }
}

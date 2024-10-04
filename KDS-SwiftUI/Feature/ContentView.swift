//
//  ContentView.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    
    private func didCreateButtonTapped() {
        withAnimation { appState.makeNewOrder() }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(appState.allOrders) { order in
                    OrderSection(order: order, appState: appState)
                }
            }
            .listStyle(.insetGrouped)
            .onAppear(perform: appState.makeNewOrder)
            .navigationTitle(Text("Food"))
            .toolbar {
                Button(action: didCreateButtonTapped) {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

private struct OrderSection: View {
    
    var order: Order
    let appState: AppState
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(order.tag)
                .font(.headline)
                .foregroundStyle(.gray)
                .padding(.horizontal, 20)
            ForEach(order.items) { item in
                OrderItemRow(orderItem: item, appState: appState)
            }
        }
    }
}

private struct OrderItemRow: View {
    
    @State private var isFinished = false
    
    var orderItem: OrderItem
    let appState: AppState
    
    private func didFinishButtonTapped() {
        withAnimation { isFinished = true }
        appState.orderItemComplete(in: orderItem.orderID, itemID: orderItem.itemID)
    }
    
    var body: some View {
        HStack {
            NameView(orderItem: orderItem)
            switch orderItem.state {
            case let .finished(completeDate):
                FinishedStateView(completeDate: completeDate)
            case let .cancelled(cancelDate):
                CancelledStateView(cancelDate: cancelDate)
            case .new:
                EmptyView()
            }
            Spacer()
            QuantityView(orderItem: orderItem)
            if !orderItem.state.isCancelled {
                FinishButtonView(isFinished: isFinished, action: didFinishButtonTapped)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .contextMenu {
            MarkAsCancelButton(appState: appState, orderItem: orderItem)
        }
    }
}

#Preview {
    ContentView()
}

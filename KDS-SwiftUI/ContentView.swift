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
    
    private func string(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    private func didFinishButtonTapped() {
        withAnimation { isFinished = true }
        appState.orderItemComplete(in: orderItem.orderID, itemID: orderItem.itemID)
    }
    
    var body: some View {
        HStack {
            Text(orderItem.name)
                .font(.headline)
            if case let .finished(completeDate) = orderItem.state {
                HStack(alignment: .bottom, spacing: 4) {
                    Text("finished at ")
                        .foregroundStyle(Color(.systemGray2))
                        .font(.footnote)
                    Text(string(completeDate))
                        .foregroundStyle(.gray)
                        .font(.caption2.bold())
                }
            }
            Spacer()
            if isFinished {
                Image(systemName: "checkmark")
                    .foregroundStyle(.red)
                    .bold()
                    .animation(.easeIn, value: isFinished)
            } else {
                Button(action: didFinishButtonTapped) {
                    Text("完成")
                }
                .animation(.easeOut, value: isFinished)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}

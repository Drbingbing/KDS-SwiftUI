//
//  AppState.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import Foundation

final class AppState: ObservableObject {
    
    private let finishedBox: any FinishedOrderBox = FinishedOrderItemBoxImpl()
    
    @Published var allOrders: [Order] = []
    
    func mockOrders() {
        Task { @MainActor in
            try await Task.sleep(for: .seconds(0.5))
            allOrders = SampleData.A1.map {
                Order(
                    orderID: $0.orderID,
                    tag: $0.tag,
                    items: $0.orderItems.map {
                        OrderItem(
                            itemID: $0.itemID,
                            orderID: $0.orderID,
                            name: $0.name,
                            quantity: $0.quantity,
                            state: .new
                        )
                    }
                )
            }
        }
    }
    
    func makeNewOrder() {
        let newOrder = SampleData.randomOrder(Int.random(in: 1...3))
            .map {
                Order(
                    orderID: $0.orderID,
                    tag: $0.tag,
                    items: $0.orderItems.map {
                        OrderItem(
                            itemID: $0.itemID,
                            orderID: $0.orderID,
                            name: $0.name,
                            quantity: $0.quantity,
                            state: .new
                        )
                    }
                )
            }
        allOrders.append(contentsOf: newOrder)
    }
    
    func orderItemComplete(in orderID: Order.ID, itemID: OrderItem.ID) {
        Task { @MainActor in
            guard let orderIndex = allOrders.firstIndex(where: { $0.orderID == orderID }),
                  let itemIndex = allOrders[orderIndex].items.firstIndex(where: { $0.itemID == itemID })
            else { return }
            
            let item = allOrders[orderIndex].items[itemIndex]
            let finishedItem = await finishedBox.add(orderItem: item)
            allOrders[orderIndex].items[itemIndex].state = .finished(finishedItem.completeDate)
        }
    }
}

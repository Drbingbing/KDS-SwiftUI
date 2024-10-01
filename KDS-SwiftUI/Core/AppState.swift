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
    
    func makeNewOrder() {
        let newOrder = SampleData.randomOrder(Int.random(in: 1...6))
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
            guard let orderIndex = findOrderPositionBy(orderID),
                  let itemIndex = findOrderItemPositionBy(itemID, in: orderIndex)
            else { return }
            
            let item = allOrders[orderIndex].items[itemIndex]
            let finishedItem = await addFinishedOrderItem(item)
            
            allOrders[orderIndex].items[itemIndex].state = .finished(finishedItem.completeDate)
        }
    }
    
    @discardableResult
    private func addFinishedOrderItem(_ orderItem: OrderItem) async -> FinishedOrderItem {
        await finishedBox.add(orderItem: orderItem)
    }
    
}


// MARK: - order and order item searching methods
extension AppState {
    
    private func findOrderPositionBy(_ orderID: Order.ID) -> Int? {
        allOrders.firstIndex(where: { $0.orderID == orderID })
    }
    
    private func findOrderItemPositionBy(_ orderItemID: OrderItem.ID, in orderPosition: Int) -> Int? {
        allOrders[orderPosition].items.firstIndex(where: { $0.itemID == orderItemID })
    }
}

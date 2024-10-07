//
//  AppState.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import Foundation

final class AppState: ObservableObject {
    
    private let finishedBox: any FinishedOrderBox = FinishedOrderItemBoxImpl()
    private let cancelledBox: any CancelledOrderBox = CancelledOrderItemBoxImpl()
    
    @Published var currentTime: String = Current.date().formatted(date: .omitted, time: .shortened)
    @Published var allOrders: [Order] = []
        
    func makeNewOrder() {
        let newOrder = SampleData.randomOrder(Int.random(in: 1...6))
            .map { order in
                Order(
                    orderID: order.orderID,
                    orderNumber: order.orderNumber,
                    diningOption: order.diningOption,
                    numberOfDiners: order.numberOfDiners,
                    items: order.orderItems.map {
                        OrderItem(
                            itemID: $0.itemID,
                            orderID: $0.orderID,
                            name: $0.name,
                            quantity: $0.quantity,
                            createAt: order.createAt,
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
    
    func orderCancelled(in orderID: Order.ID, itemID: OrderItem.ID) {
        Task { @MainActor in
            guard let orderIndex = findOrderPositionBy(orderID),
                  let itemIndex = findOrderItemPositionBy(itemID, in: orderIndex)
            else { return }
            
            let item = allOrders[orderIndex].items[itemIndex]
            let cancelledItem = await addCancelledOrderItem(item)
            
            allOrders[orderIndex].items[itemIndex].state = .cancelled(cancelledItem.cancelledDate)
        }
    }
    
    func markAllAsCompleted() {
        Task { @MainActor in
            let indexPaths = findNewOrderItemsPosition()
            let orderItems = indexPaths.map { allOrders[$0.section].items[$0.index] }
            let finishedItems = await addFinishedOrderItems(orderItems)
            
            for (left, right) in zip(indexPaths, finishedItems) {
                allOrders[left.section].items[left.index].state = .finished(right.completeDate)
            }
        }
    }
}

// MARK: - finished box
extension AppState {
    
    @discardableResult
    private func addFinishedOrderItem(_ orderItem: OrderItem) async -> FinishedOrderItem {
        await finishedBox.add(orderItem: orderItem)
    }
    
    @discardableResult
    private func addFinishedOrderItems(_ orderItems: [OrderItem]) async -> [FinishedOrderItem] {
        await finishedBox.add(orderItems: orderItems)
    }
}

// MARK: - cancel box
extension AppState {
    
    @discardableResult
    private func addCancelledOrderItem(_ orderItem: OrderItem) async -> CancelledOrderItem {
        await cancelledBox.add(orderItem: orderItem)
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
    
    private func findNewOrderItemsPosition() -> [(section: Int, index: Int)] {
        var result: [(section: Int, index: Int)] = []
        for orderIndex in 0..<allOrders.count {
            let items = allOrders[orderIndex].items
            for itemIndex in 0..<items.count {
                if items[itemIndex].state.isNew {
                    result.append((orderIndex, itemIndex))
                }
            }
        }
        
        return result
    }
}

//
//  OrderInteractor.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/7.
//

import SwiftUI
import Combine

protocol OrderInteractor {
    
    func makeNewOrder()
    func orderItemComplete(in orderID: Order.ID, itemID: OrderItem.ID)
    func orderItemCancelled(in orderID: Order.ID, itemID: OrderItem.ID)
    func markAllAsCompleted()
}

struct OrderInteractorImpl: OrderInteractor {
    
    private let appState: AppState
    private let finishedOrderRepository: any FinishedOrderRepository
    private let cancelledOrderRepository: any CancelledOrderRepository
    
    init(appState: AppState) {
        self.appState = appState
        self.finishedOrderRepository = FinishedOrderRepositoryImpl()
        self.cancelledOrderRepository = CancelledOrderRepositoryImpl()
    }
    
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
        
        appState.allOrders.append(contentsOf: newOrder)
    }
    
    func orderItemComplete(in orderID: Order.ID, itemID: OrderItem.ID) {
        Task { @MainActor in
            guard let orderIndex = findOrderPositionBy(orderID),
                  let itemIndex = findOrderItemPositionBy(itemID, in: orderIndex)
            else { return }
            
            let item = appState.allOrders[orderIndex].items[itemIndex]
            let finishedItem = await addFinishedOrderItem(item)
            
            appState.allOrders[orderIndex].items[itemIndex].state = .finished(finishedItem.completeDate)
        }
    }
    
    func orderItemCancelled(in orderID: Order.ID, itemID: OrderItem.ID) {
        Task { @MainActor in
            guard let orderIndex = findOrderPositionBy(orderID),
                  let itemIndex = findOrderItemPositionBy(itemID, in: orderIndex)
            else { return }
            
            let item = appState.allOrders[orderIndex].items[itemIndex]
            let cancelledItem = await addCancelledOrderItem(item)
            
            appState.allOrders[orderIndex].items[itemIndex].state = .cancelled(cancelledItem.cancelledDate)
        }
    }
    
    func markAllAsCompleted() {
        Task { @MainActor in
            let indexPaths = findNewOrderItemsPosition()
            let orderItems = indexPaths.map { appState.allOrders[$0.section].items[$0.index] }
            let finishedItems = await addFinishedOrderItems(orderItems)
            
            for (left, right) in zip(indexPaths, finishedItems) {
                appState.allOrders[left.section].items[left.index].state = .finished(right.completeDate)
            }
        }
    }
}


// MARK: - finished box
extension OrderInteractorImpl {
    
    @discardableResult
    private func addFinishedOrderItem(_ orderItem: OrderItem) async -> FinishedOrderItem {
        await finishedOrderRepository.add(orderItem: orderItem)
    }
    
    @discardableResult
    private func addFinishedOrderItems(_ orderItems: [OrderItem]) async -> [FinishedOrderItem] {
        await finishedOrderRepository.add(orderItems: orderItems)
    }
}

// MARK: - cancel box
extension OrderInteractorImpl {
    
    @discardableResult
    private func addCancelledOrderItem(_ orderItem: OrderItem) async -> CancelledOrderItem {
        await cancelledOrderRepository.add(orderItem: orderItem)
    }
}

// MARK: - order and order item searching methods
extension OrderInteractorImpl {
    
    private func findOrderPositionBy(_ orderID: Order.ID) -> Int? {
        appState.allOrders.firstIndex(where: { $0.orderID == orderID })
    }
    
    private func findOrderItemPositionBy(_ orderItemID: OrderItem.ID, in orderPosition: Int) -> Int? {
        appState.allOrders[orderPosition].items.firstIndex(where: { $0.itemID == orderItemID })
    }
    
    private func findNewOrderItemsPosition() -> [(section: Int, index: Int)] {
        var result: [(section: Int, index: Int)] = []
        for orderIndex in 0..<appState.allOrders.count {
            let items = appState.allOrders[orderIndex].items
            for itemIndex in 0..<items.count {
                if items[itemIndex].state.isNew {
                    result.append((orderIndex, itemIndex))
                }
            }
        }
        
        return result
    }
}

struct StubOrderInteractor: OrderInteractor {
    func makeNewOrder() {}
    
    func orderItemComplete(in orderID: Order.ID, itemID: OrderItem.ID) {
        print("[StubOrderInteractor]")
    }
    
    func orderItemCancelled(in orderID: Order.ID, itemID: OrderItem.ID) {
        print("[StubOrderInteractor]")
    }
    
    func markAllAsCompleted() {
        print("[StubOrderInteractor]")
    }
}

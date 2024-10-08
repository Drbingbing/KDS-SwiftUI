//
//  FinishedOrderRepository.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

protocol FinishedOrderRepository: Actor {
    
    func add(orderItems: [OrderItem]) async -> [FinishedOrderItem]
    func add(orderItem: OrderItem) async -> FinishedOrderItem
    func remove(_ orderItems: [OrderItem]) async
}

extension FinishedOrderRepository {
    func add(orderItem: OrderItem) async -> FinishedOrderItem {
        return await add(orderItems: [orderItem]).first!
    }
}

actor FinishedOrderRepositoryImpl: FinishedOrderRepository {
    
    private var context: [AnyHashable: FinishedOrderItem] = [:]
    
    func add(orderItems: [OrderItem]) async -> [FinishedOrderItem] {
        let keyAndValues = orderItems.map { ($0.itemID, convertToFinishedOrderItem($0) ) }
        let dict = Dictionary(keyAndValues, uniquingKeysWith: { $1 })
        let savedItems = dict.map(\.value)
        context.merge(dict, uniquingKeysWith: { $1 })
        await Current.database.save(finishedOrderItems: savedItems)
        
        return savedItems
    }
    
    func remove(_ orderItems: [OrderItem]) async {
        let keys = orderItems.map(\.itemID)
        let values = keys.compactMap { context.removeValue(forKey: $0) }
        await Current.database.remove(finishedOrderItems: values)
    }
}

private func convertToFinishedOrderItem(_ from: OrderItem) -> FinishedOrderItem {
    FinishedOrderItem(itemID: from.itemID, completeDate: Current.date(), quantity: from.quantity)
}

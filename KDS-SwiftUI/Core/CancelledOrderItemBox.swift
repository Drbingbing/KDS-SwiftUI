//
//  CancelledOrderItemBox.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

protocol CancelledOrderBox: Actor {
    
    func add(orderItems: [OrderItem]) async -> [CancelledOrderItem]
    func add(orderItem: OrderItem) async -> CancelledOrderItem
    func remove(_ orderItems: [OrderItem]) async
}

extension CancelledOrderBox {
    func add(orderItem: OrderItem) async -> CancelledOrderItem {
        return await add(orderItems: [orderItem]).first!
    }
}

actor CancelledOrderItemBoxImpl: CancelledOrderBox {
    
    private var context: [AnyHashable: CancelledOrderItem] = [:]
    
    func add(orderItems: [OrderItem]) async -> [CancelledOrderItem] {
        let keyAndValues = orderItems.map { ($0.itemID, convertToCancelleddOrderItem($0) ) }
        let dict = Dictionary(keyAndValues, uniquingKeysWith: { $1 })
        let itemsToSave = dict.map(\.value)
        context.merge(dict, uniquingKeysWith: { $1 })
        await Current.database.save(cancelledOrderItems: itemsToSave)
        
        return itemsToSave
    }
    
    func remove(_ orderItems: [OrderItem]) async {
        let keys = orderItems.map(\.itemID)
        let values = keys.compactMap { context.removeValue(forKey: $0) }
        await Current.database.remove(cancelledOrderItems: values)
    }
}

private func convertToCancelleddOrderItem(_ from: OrderItem) -> CancelledOrderItem {
    CancelledOrderItem(itemID: from.itemID, cancelledDate: Current.date())
}

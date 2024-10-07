//
//  Environment.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import Foundation

public struct Environment {
    public var database = Storage()
    public var date: () -> Date = Date.init
}

public var Current = Environment()

public struct Storage {
    
    private static let store = Database()
    
    public var saveFinishedOrderItems: ([FinishedOrderItem]) async -> Void = { _ in store.save() }
    public func save(finishedOrderItems orderItems: [FinishedOrderItem]) async {
        await saveFinishedOrderItems(orderItems)
    }
    
    public var removeFinishedOrderItems: ([FinishedOrderItem]) async -> Void = { _ in store.delete() }
    public func remove(finishedOrderItems orderItems: [FinishedOrderItem]) async {
        await removeFinishedOrderItems(orderItems)
    }
    
    public var saveCancelledOrderItems: ([CancelledOrderItem]) async -> Void = { _ in store.save() }
    public func save(cancelledOrderItems orderItems: [CancelledOrderItem]) async {
        await saveCancelledOrderItems(orderItems)
    }
    
    public var removeCancelledOrderItems: ([CancelledOrderItem]) async -> Void = { _ in store.delete() }
    public func remove(cancelledOrderItems orderItems: [CancelledOrderItem]) async {
        await removeCancelledOrderItems(orderItems)
    }
}

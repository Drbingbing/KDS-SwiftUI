//
//  ItemSection.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct OrderSection: View {
    
    var order: Order
    let appState: AppState
    
    var body: some View {
        VStack(alignment: .leading) {
            OrderHeader(order: order)
                .padding(.horizontal, 20)
            ForEach(order.items) { item in
                OrderItemRow(orderItem: item, appState: appState)
            }
        }
    }
}

struct OrderHeader: View {
    var order: Order
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            OrderDiningOptionView(order: order)
            OrderNumberView(order: order)
            OrderDinersSizeView(order: order)
        }
    }
}

struct OrderNumberView: View {
    var order: Order
    
    var body: some View {
        Text(order.orderNumber)
            .font(.headline)
            .foregroundStyle(.gray)
    }
}

struct OrderDiningOptionView: View {
    var order: Order
    
    var body: some View {
        Text(displayDiningOption)
            .font(.headline)
            .foregroundStyle(.orange)
            .padding(6)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var displayDiningOption: String {
        switch order.diningOption {
        case .dineIn:
            return "Dine-in"
        case .takeout:
            return "Takeout"
        case .delivery:
            return "Delivery"
        }
    }
}

struct OrderDinersSizeView: View {
    var order: Order
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "person.fill")
                .foregroundStyle(Color.gray)
            Text("\(order.numberOfDiners)")
                .font(.headline)
                .foregroundStyle(.gray)
        }
    }
}

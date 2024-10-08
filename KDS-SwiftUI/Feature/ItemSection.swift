//
//  ItemSection.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct OrderSection: View {
    
    var order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            OrderHeader(order: order)
                .padding(.horizontal, 20)
            ForEach(order.items) { item in
                OrderItemRow(orderItem: item)
            }
        }
    }
}

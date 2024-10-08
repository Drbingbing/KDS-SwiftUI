//
//  GridOrderHeader.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/8.
//

import SwiftUI

struct GridOrderHeader: View {
    
    var order: Order
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                OrderDiningOptionView(order: order)
                Spacer()
                OrderNumberView(order: order)
            }
            
            HStack(spacing: 0) {
                OrderDinersSizeView(order: order)
                Spacer()
                OrderSourceView(order: order)
            }
        }
    }
}

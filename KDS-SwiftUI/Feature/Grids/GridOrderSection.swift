//
//  GridOrderItem.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/8.
//

import SwiftUI

struct GridOrderSection: View {
    
    var order: Order
    
    var body: some View {
        VStack {
            GridOrderHeader(order: order)
            GridItemRow(order: order)
        }
    }
}

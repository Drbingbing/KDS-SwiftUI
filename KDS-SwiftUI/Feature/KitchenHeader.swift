//
//  KitchenHeader.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct KitchenHeader: View {
    var body: some View {
        GeometryReader { metrics in
            HStack {
                Text("#")
                    .frame(width: metrics.size.width * 0.05)
                Text("Time")
                    .frame(width: metrics.size.width * 0.1)
                Text("ItemName")
                    .frame(maxWidth: .infinity)
                Text("Quantity")
                    .frame(width: metrics.size.width * 0.1)
                Text("Source")
                    .frame(width: metrics.size.width * 0.1)
                Text("Complete all")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .frame(width: metrics.size.width * 0.15)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 32)
    }
}

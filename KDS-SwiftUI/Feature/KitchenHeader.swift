//
//  KitchenHeader.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct KitchenHeader: View {
    var body: some View {
        HStack {
            Text("#")
            Text("Time")
            Text("ItemName")
            Text("Quantity")
            Text("Source")
            Text("Complete all")
                .foregroundStyle(Color.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

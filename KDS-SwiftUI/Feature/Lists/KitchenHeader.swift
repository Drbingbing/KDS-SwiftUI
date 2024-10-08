//
//  KitchenHeader.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct KitchenHeader: View {
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment: AppEnvironment
    
    
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 0) {
                Text("#")
                    .frame(width: metrics.size.width * Constant.Ratio.hash, alignment: .leading)
                Text("Time")
                    .frame(width: metrics.size.width * Constant.Ratio.time, alignment: .leading)
                Text("ItemName")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Quantity")
                    .frame(width: metrics.size.width * Constant.Ratio.quantity)
                Text("Source")
                    .frame(width: metrics.size.width * Constant.Ratio.source)
                Button(action: appEnvironment.interactors.orderInteractor.markAllAsCompleted) {
                    Text("Complete all")
                }
                .foregroundStyle(Color.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .frame(width: metrics.size.width * Constant.Ratio.complete)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 32)
        .padding(.horizontal, 20)
    }
}

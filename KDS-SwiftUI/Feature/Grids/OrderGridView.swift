//
//  OrderGridView.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/8.
//

import SwiftUI

struct OrderGridView: View {
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment: AppEnvironment
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        GeometryReader { metrcis in
            
            let spacing: CGFloat = 8
            let availableWidth = metrcis.size.width
            let cellWidth = (availableWidth - 3 * spacing) * 0.25
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(appState.allOrders, id: \.self) { order in
                        GridOrderSection(order: order)
                            .frame(width: cellWidth, height: metrcis.size.height)
                    }
                }
            }
            .onAppear {
                if appState.allOrders.isEmpty {
                    appEnvironment.interactors.orderInteractor.makeNewOrder()
                }
            }
        }
        .padding(.horizontal, 12)
    }
}

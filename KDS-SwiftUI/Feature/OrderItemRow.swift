//
//  OrderItemRow.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct OrderItemRow: View {
    
    @State private var isFinished = false
    
    var orderItem: OrderItem
    let appState: AppState
    
    private func didFinishButtonTapped() {
        withAnimation { isFinished = true }
        appState.orderItemComplete(in: orderItem.orderID, itemID: orderItem.itemID)
    }
    
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 0) {
                NumberSignView(orderItem: orderItem)
                    .frame(width: metrics.size.width * 0.05)
                TimeView(orderItem: orderItem)
                    .frame(width: metrics.size.width * 0.1)
                NameView(orderItem: orderItem)
                    .layoutPriority(1)
                switch orderItem.state {
                case let .finished(completeDate):
                    FinishedStateView(completeDate: completeDate)
                case let .cancelled(cancelDate):
                    CancelledStateView(cancelDate: cancelDate)
                case .new:
                    EmptyView()
                }
                Spacer()
                QuantityView(orderItem: orderItem)
                    .frame(width: metrics.size.width * 0.05)
                SourceView(orderItem: orderItem)
                    .frame(width: metrics.size.width * 0.1)
                if !orderItem.state.isCancelled {
                    FinishButtonView(isFinished: isFinished, action: didFinishButtonTapped)
                        .frame(width: metrics.size.width * 0.1)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .contextMenu {
                MarkAsCancelButton(appState: appState, orderItem: orderItem)
            }
            .frame(width: .infinity)
        }
        .frame(minHeight: 36)
    }
}

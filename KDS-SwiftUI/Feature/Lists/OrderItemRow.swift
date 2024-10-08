//
//  OrderItemRow.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct OrderItemRow: View {
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment: AppEnvironment
    
    @EnvironmentObject var appState: AppState
    @State private var isFinished = false
    
    var orderItem: OrderItem
    
    private func didFinishButtonTapped() {
        withAnimation { isFinished = true }
        appEnvironment.interactors.orderInteractor.orderItemComplete(in: orderItem.orderID, itemID: orderItem.itemID)
    }
    
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 0) {
                NumberSignView(orderItem: orderItem)
                    .frame(width: metrics.size.width * Constant.Ratio.hash, alignment: .leading)
                TimeView(orderItem: orderItem)
                    .frame(width: metrics.size.width * Constant.Ratio.time, alignment: .leading)
                NameView(orderItem: orderItem)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                    .frame(width: metrics.size.width * Constant.Ratio.quantity)
                SourceView(orderItem: orderItem)
                    .frame(width: metrics.size.width * Constant.Ratio.source)
                FinishButtonView(orderItem: orderItem, isFinished: isFinished ? isFinished : orderItem.state.isFinished, action: didFinishButtonTapped)
                    .frame(width: metrics.size.width * Constant.Ratio.complete)
            }
            .padding(.vertical, 8)
            .strikethrough(orderItem.state.isCancelled)
        }
        .frame(minHeight: 40)
        .padding(.horizontal, 20)
        .contextMenu {
            MarkAsCancelButton(appState: appState, orderItem: orderItem)
        }
    }
}

//
//  GridItemRow.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/8.
//

import SwiftUI

struct GridItemRow: View {
    
    var order: Order
    
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                if let first = order.items.first {
                    GridOrderItemTimeView(createAt: first.createAt)
                }
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 0.5)
                ForEach(order.items) { orderItem in
                    GirdOrderItemRow(orderItem: orderItem)
                }
            }
        }
    }
}

struct GridOrderItemTimeView: View {
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment
    
    @State private var timeProcessing: String = ""
    
    var createAt: Double
    
    init(createAt: Double) {
        self.createAt = createAt
    }
    
    var body: some View {
        HStack {
            Text("Time Processing")
                .font(.headline)
                .foregroundStyle(Color.gray)
            Spacer()
            Text(timeProcessing)
                .font(.headline)
                .foregroundStyle(Color.gray)
                .onTimerFired(every: 1, isRepeat: true) { subscription in
                    let elapsed = appEnvironment.current.date().timeIntervalSince1970 - createAt
                    let hr = (elapsed/3600).rounded(.towardZero)
                    let mm = ((elapsed - 3600 * hr)/60).rounded(.towardZero)
                    let ss = (elapsed - (3600 * hr) - (60 * mm)).rounded(.towardZero)
                    let hour = String(format: hr < 100 ? "%02.0f" : "%03.0f", hr)
                    let minutes = String(format: "%02.0f", mm)
                    let seconds = String(format: "%02.0f", ss)
                    timeProcessing = "\(hour):\(minutes):\(seconds)"
                }
        }
    }
}

struct GirdOrderItemRow: View {
    
    @SwiftUI.Environment(\.appEnvironment) var appEnvironment
    @EnvironmentObject var appState: AppState
    
    var orderItem: OrderItem

    @State private var isFinished = false
    
    private func didFinishButtonTapped() {
        withAnimation { isFinished = true }
        appEnvironment.interactors.orderInteractor.orderItemComplete(in: orderItem.orderID, itemID: orderItem.itemID)
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            QuantityView(orderItem: orderItem)
            NameView(orderItem: orderItem)
                .layoutPriority(1)
            switch orderItem.state {
            case let .finished(completeDate):
                FinishedStateView(completeDate: completeDate, style: .shortend)
            case let .cancelled(cancelDate):
                CancelledStateView(cancelDate: cancelDate)
            case .new:
                EmptyView()
            }
            Spacer()
            FinishButtonView(orderItem: orderItem, isFinished: isFinished ? isFinished : orderItem.state.isFinished, action: didFinishButtonTapped)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 6)
        .contextMenu {
            MarkAsCancelButton(appState: appState, orderItem: orderItem)
        }
    }
}

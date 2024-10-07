//
//  ItemView.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI
import Combine

struct NumberSignView: View {
    var orderItem: OrderItem
    
    var body: some View {
        Text("#")
            .font(.headline)
            .strikethrough(orderItem.state.isCancelled, color: Color.secondary)
    }
}

struct TimeView: View {
    @State private var timeProcessing: String = ""
    
    var orderItem: OrderItem
    
    init(orderItem: OrderItem) {
        self.orderItem = orderItem
    }
    
    var body: some View {
        Text(timeProcessing)
            .font(.headline)
            .foregroundStyle(Color.gray)
            .strikethrough(orderItem.state.isCancelled, color: Color.secondary)
            .onTimerFired(every: 1, isRepeat: true) { subscription in
                if orderItem.state.isCancelled || orderItem.state.isFinished {
                    subscription?.cancel()
                    timeProcessing = ""
                    return
                }
                let elapsed = Current.date().timeIntervalSince1970 - orderItem.createAt
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

struct NameView: View {
    var orderItem: OrderItem
    
    var body: some View {
        Text(orderItem.name)
            .font(.headline)
            .strikethrough(orderItem.state.isCancelled, color: Color.secondary)
    }
}

struct SourceView: View {
    var orderItem: OrderItem
    
    var body: some View {
        Text("boss")
            .foregroundStyle(Color.brown)
            .bold()
            .strikethrough(orderItem.state.isCancelled, color: Color.secondary)
    }
}

struct QuantityView: View {
    var orderItem: OrderItem
    
    var body: some View {
        Text("\(orderItem.quantity)")
            .foregroundStyle(Color.brown)
            .bold()
            .strikethrough(orderItem.state.isCancelled, color: Color.secondary)
    }
}

struct FinishButtonView: View {
    var orderItem: OrderItem
    var isFinished: Bool
    var action: () -> Void
    
    var body: some View {
        if orderItem.state.isCancelled {
            Text("Cancelled")
                .foregroundStyle(Color.red)
        }
        else if isFinished {
            Image(systemName: "checkmark")
                .foregroundStyle(.red)
                .bold()
                .animation(.easeIn, value: isFinished)
        } else {
            Button(action: action) {
                Text("Finish")
            }
            .animation(.easeOut, value: isFinished)
        }
    }
}

struct FinishedStateView: View {
    var completeDate: Date
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Text("finished at ")
                .foregroundStyle(Color(.systemGray2))
                .font(.footnote)
            Text(string(completeDate))
                .foregroundStyle(.gray)
                .font(.caption2.bold())
        }
    }
    
    private func string(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

struct CancelledStateView: View {
    var cancelDate: Date
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Text("cancelled at ")
                .foregroundStyle(Color(.systemGray2))
                .font(.footnote)
            Text(string(cancelDate))
                .foregroundStyle(.gray)
                .font(.caption2.bold())
        }
    }
    
    private func string(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

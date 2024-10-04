//
//  ItemView.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/4.
//

import SwiftUI

struct NameView: View {
    var orderItem: OrderItem
    
    var body: some View {
        Text(orderItem.name)
            .font(.headline)
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
    var isFinished: Bool
    var action: () -> Void
    
    var body: some View {
        if isFinished {
            Image(systemName: "checkmark")
                .foregroundStyle(.red)
                .bold()
                .animation(.easeIn, value: isFinished)
        } else {
            Color.clear.frame(width: 20)
            Button(action: action) {
                Text("完成")
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

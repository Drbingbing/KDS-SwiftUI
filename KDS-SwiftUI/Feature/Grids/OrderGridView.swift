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
                    ForEach(0..<3, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.gray)
                            .frame(width: cellWidth, height: metrcis.size.height)
                    }
                }
            }
        }
        .padding(.horizontal, 12)
    }
}

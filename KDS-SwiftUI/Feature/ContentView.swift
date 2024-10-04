//
//  ContentView.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/1.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    
    private func didCreateButtonTapped() {
        withAnimation { appState.makeNewOrder() }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(appState.allOrders) { order in
                    OrderSection(order: order, appState: appState)
                }
            }
            .listStyle(.insetGrouped)
            .onAppear(perform: appState.makeNewOrder)
            .navigationTitle(Text("Food"))
            .toolbar {
                Button(action: didCreateButtonTapped) {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

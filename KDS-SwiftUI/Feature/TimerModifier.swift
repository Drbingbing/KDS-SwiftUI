//
//  TimerModifier.swift
//  KDS-SwiftUI
//
//  Created by BingBing on 2024/10/7.
//

import SwiftUI
import Combine

struct TimerModifier: ViewModifier {
    
    @State private var timer: Timer.TimerPublisher
    @State private var handler: Cancellable?
    
    private var isRepeat: Bool
    private var every: TimeInterval
    private var callback: (Cancellable?) -> Void
    
    init(every: TimeInterval, isRepeat: Bool, onCallback callback: @escaping (Cancellable?) -> Void) {
        self.callback = callback
        self.every = every
        self.isRepeat = isRepeat
        
        let publisher = Timer.publish(every: every, on: .main, in: .common)
        _timer = .init(initialValue: publisher)
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: setTimer)
            .onReceive(timer) { time in
                if !isRepeat {
                    cancelTimer()
                }
                callback(handler)
            }
    }
    
    private func setTimer() {
        handler?.cancel()
        timer = Timer.publish(every: every, on: .main, in: .common)
        handler = timer.connect()
    }
    
    private func cancelTimer() {
        handler?.cancel()
    }
}

extension View {
    
    func onTimerFired(every: TimeInterval, isRepeat: Bool, onCallback callback: @escaping (Cancellable?) -> Void) -> some View {
        modifier(TimerModifier(every: every, isRepeat: isRepeat, onCallback: callback))
    }
    
}

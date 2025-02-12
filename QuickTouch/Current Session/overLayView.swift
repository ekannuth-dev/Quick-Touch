//
//  overLayView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-11.
//

import SwiftUI

import SwiftUI

//struct FullScreenOverlay: View {
//    @ObservedObject var currentSession: sessionViewModel
//    @State private var currentIndex = 0
//
//    var body: some View {
//        ZStack {
//            if currentSession.isIntervalSession {
//                currentSession.intervalColor[currentIndex] // ✅ Cycles through colors
//                    .ignoresSafeArea()
//            } else {
//                Color.clear.ignoresSafeArea() // Default state
//            }
//        }
//        .onAppear {
//            startLoopingColors()
//        }
//    }
//
//    private func startLoopingColors() {
//        guard !currentSession.intervalColor.isEmpty else { return }
//        Timer.scheduledTimer(withTimeInterval: Double(currentSession.sessionInterval), repeats: true) { _ in
//                currentIndex = (currentIndex + 1) % currentSession.intervalColor.count
//        }
//    }
//}


import SwiftUI
import Combine

struct FullScreenOverlay: View {
    @ObservedObject var currentSession: sessionViewModel
    @State private var currentIndex = 0
    @State private var timerCancellable: AnyCancellable?

    var body: some View {
        ZStack {
            if currentSession.isIntervalSession, !currentSession.intervalColor.isEmpty {
                currentSession.intervalColor[currentIndex]
                    .ignoresSafeArea()
            } else {
                Color.clear.ignoresSafeArea()
            }
        }
        .onAppear {
            startLoopingColors() // ✅ Start precise timer
        }
        .onDisappear {
            stopTimer() // ✅ Stop timer when leaving view
        }
    }

    /// ✅ Starts a precise timer that fires at exactly `sessionInterval` seconds
    private func startLoopingColors() {
        stopTimer() // ✅ Prevent multiple timers from stacking
        guard !currentSession.intervalColor.isEmpty else { return }

        // ✅ Timer fires every `sessionInterval` seconds
        timerCancellable = Timer.publish(every: max(1.0, Double(currentSession.sessionInterval)), on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main) // ✅ Ensure it updates the UI correctly
            .sink { _ in
                currentIndex = (currentIndex + 1) % currentSession.intervalColor.count
            }
    }

    /// ✅ Stops the timer safely
    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}

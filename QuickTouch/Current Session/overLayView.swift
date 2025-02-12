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

struct FullScreenOverlay: View {
    @ObservedObject var currentSession: sessionViewModel
    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            if currentSession.isIntervalSession, !currentSession.intervalColor.isEmpty {
                currentSession.intervalColor[currentIndex] // ✅ Cycles through colors
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 0.5), value: currentIndex) // ✅ Smooth transition
            } else {
                Color.clear.ignoresSafeArea() // ✅ Default background
            }
        }
        .onAppear {
            startLoopingColors() // ✅ Start timer when view appears
        }
        .onDisappear {
            stopTimer() // ✅ Stop timer when view disappears
        }
    }

    /// ✅ Starts the looping timer with `sessionInterval`
    private func startLoopingColors() {
        stopTimer() // ✅ Ensure only one timer runs at a time
        guard !currentSession.intervalColor.isEmpty else { return }

        timer = Timer.scheduledTimer(withTimeInterval: Double(currentSession.sessionInterval), repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % currentSession.intervalColor.count // ✅ Circular looping
            }
        }
    }

    /// ✅ Stops the timer when leaving the view
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

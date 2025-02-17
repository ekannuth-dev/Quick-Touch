//
//  overLayView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-11.
//


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
            startLoopingColors()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private func startLoopingColors() {
        stopTimer()
        guard !currentSession.intervalColor.isEmpty else { return }
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main) // ✅ Ensure it updates the UI correctly
            .sink { _ in
                currentIndex = Int.random(in: 0..<currentSession.intervalColor.count)
            }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}

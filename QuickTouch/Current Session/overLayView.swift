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
        colorOverlayView()
            .onChange(of: currentSession.play) { oldisPlaying , isPlaying in
                if isPlaying {
                    startLoopingColors()
                } else {
                    stopTimer()
                }
            }
            .onDisappear {
                stopTimer()
            }
    }
    
    private func colorOverlayView() -> some View {
        ZStack {
            if !currentSession.intervalColor.isEmpty {
                currentSession.intervalColor[currentIndex]
                    .ignoresSafeArea()
            } else {
                Color.clear.ignoresSafeArea()
            }
        }
    }

    private func startLoopingColors() {
        stopTimer()
        guard !currentSession.intervalColor.isEmpty else { return }
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                currentIndex = Int.random(in: 0..<currentSession.intervalColor.count)
            }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}

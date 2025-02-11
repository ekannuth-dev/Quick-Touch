//
//  overLayView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-11.
//

import SwiftUI

import SwiftUI

struct FullScreenOverlay: View {
    @ObservedObject var currentSession: sessionViewModel
    @State private var currentIndex = 0 // ✅ Keeps track of the current color index

    var body: some View {
        ZStack {
            if currentSession.isIntervalSession {
                currentSession.intervalColor[currentIndex] // ✅ Cycles through colors
                    .ignoresSafeArea()
              //      .animation(.easeInOut(duration: 1), value: currentIndex) // Smooth transition
            } else {
                Color.clear.ignoresSafeArea() // Default state
            }
        }
        .onAppear {
            startLoopingColors()
        }
    }

    // ✅ Loops through the colors every 2 seconds
    private func startLoopingColors() {
        guard !currentSession.intervalColor.isEmpty else { return } // Prevent crash

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentIndex = (currentIndex + 1) % currentSession.intervalColor.count // ✅ Loops back to start
        }
    }
}

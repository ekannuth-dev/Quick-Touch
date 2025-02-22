//
//  circularTimerView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-30.
//

import Foundation
import SwiftUI
import Combine



struct circularTimer : View {
    @ObservedObject var currentSession: sessionViewModel
    var body: some View {
        ZStack {
            if currentSession.isIntervalSession {
                // Full screen overlay with just the buttons
                ZStack {
                    FullScreenOverlay(currentSession: currentSession)
                    
                    // Only show buttons when overlay is active
                    
                    sessionButtons(sameSession: currentSession)

                }
            } else {
                // Normal timer view when no overlay
                VStack {
                    ZStack {
                        // Timer circles
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 10)
                                .foregroundColor(.blue.opacity(0.4))
                            Circle()
                                .trim(from: 0.0, to: CGFloat(1 - currentSession.progress))
                                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                .foregroundColor(.blue)
                                .rotationEffect(.degrees(-90.0))
                                .shadow(radius: 2)
                                .animation(.linear(duration: 1.0),value: currentSession.progress)
                        }
                        .frame(width: 270, height: 270)
                        
                        // Timer text
                        Text(currentSession.timerText)
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                            .bold()
                    }
                    
                    sessionButtons(sameSession: currentSession)
                }
                .padding(50)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            currentSession.setupTimer()
        }
    }
}

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
            VStack {
                ZStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20)
                            .foregroundColor(.blue.opacity(0.4))
                        Circle()
                            .trim(from: 0.0, to: CGFloat(1 - currentSession.progress))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                            .foregroundColor(.blue)
                            .rotationEffect(.degrees(-90.0))
                            .shadow(radius: 2)
                            .animation(.linear(duration: 1.0),value: currentSession.progress)
                    }
                    .frame(width: 330, height: 330)
                    Text(currentSession.timerText)
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                        .bold()
                }
                sessionButtons(sameSession: currentSession)
            }
            .padding(50)
            FullScreenOverlay(currentSession: currentSession)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            currentSession.setupTimer()
        }
    }
}

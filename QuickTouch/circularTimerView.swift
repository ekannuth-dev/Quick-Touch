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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var minutes : Int
    @State var seconds : Int
    @State private var timerText: String = ""
    @State private var progress: Float = 0.0
    @State private var step: Float = 0.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 30)
                .foregroundColor(.blue.opacity(0.4))
            Circle()
                .trim(from: 0.0, to: CGFloat(1-progress))
                .stroke(lineWidth: 30)
                .foregroundColor(.blue)
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.1), value: progress)
            Text(timerText)
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .bold()
                .onReceive(timer) { _ in
                    if seconds > 0 {
                        seconds -= 1
                    } else if seconds == 0 && minutes != 0 {
                        minutes -= 1
                        seconds = 59
                    }
                    if seconds <= 9 {
                        timerText = "\(minutes):0\(seconds)"
                    } else {
                        timerText = "\(minutes):\(seconds)"
                    }
                    progress += step
                }
        }
        .padding(50)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            timerText = "\(minutes):\(seconds)"
            let totalSeconds = Float(minutes * 60 + seconds)
                        step = totalSeconds > 0 ? 1 / totalSeconds : 0
        }
    }
}

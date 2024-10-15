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
    @Binding var minutes : Int
    @Binding var seconds : Int
    @Binding var resetSession : Bool
    @Binding var playSession : Bool
    @State private var timerText: String = ""
    @State private var progress: Float = 0.0
    @State private var step: Float = 0.0
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .foregroundColor(.blue.opacity(0.4))
                    Circle()
                        .trim(from: 0.0, to: CGFloat(1-progress))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(-90.0))
                        .shadow(radius: 2)
                        .animation(.linear(duration: 1.0), value: progress)
                }
                Text(timerText)
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .bold()
                    .onReceive(timer) {_ in
                        if playSession {
                            if seconds > 0 {
                                seconds -= 1
                            } else if seconds == 0 && minutes != 0 {
                                minutes -= 1
                                seconds = 59
                            }
                            if seconds == 0 && minutes == 0 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { // 2-second delay
                                    withAnimation {
                                        resetSession = true
                                    }
                                }
                            }
                            if seconds <= 9 {
                                timerText = "\(minutes):0\(seconds)"
                            }
                            else {
                                timerText = "\(minutes):\(seconds)"
                            }
                            progress += step
                        }
                    }
            }
        }
        .padding(50)
        .navigationBarBackButtonHidden(true)
        HStack {
            Button {
                playSession.toggle()
            }
        label: {
            Image(systemName:  playSession ? "pause.fill" : "play.fill")
                .resizable()               // Make the image resizable
                .frame(width: 25, height: 25)
        }
        }
        .onAppear {
            if seconds <= 9 {
                timerText = "\(minutes):0\(seconds)"
            }
            else {
                timerText = "\(minutes):\(seconds)"
            }
            let totalSeconds = Float(minutes * 60 + seconds)
            step = totalSeconds > 0 ? 1 / totalSeconds : 0
        }
    }
}

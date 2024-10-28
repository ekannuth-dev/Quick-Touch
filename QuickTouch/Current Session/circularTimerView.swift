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
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let minutes : Int
    let seconds : Int
    @State var minRemain: Int
    @State var secRemain: Int
    @Binding var reset: Bool
    @State var resetSession : Bool = false
    @State var playSession : Bool = false
    @State private var timerText: String = ""
    @State private var progress: Float = 0.0
    @State private var step: Float = 0.0
    @State var timeElapsed = 0
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
                .frame(width: 330, height: 330)
                Text(timerText)
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .bold()
                    .onReceive(timer) {_ in
                        if resetSession == true {
                            let _ = print(progress)
                            if progress <= 0 {
                                setResetsession()
                            }
                            else {
                                progress -= step
                            }
                        }
                        else if !playSession {
                            if secRemain != 0 {
                                secRemain -= 1
                            }
                            else if minRemain != 0 && secRemain == 0 {
                                minRemain -= 1
                                secRemain = 59
                            }
                            else if minRemain == 0 && secRemain == 0 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2-second delay
                                    withAnimation {
                                        reset = true
                                    }
                                }
                            }
                            setTimertext()
                            updateProgress()
                        }
                    }
            }
            sessionButtons(play: $playSession, reset: $resetSession)
        }
        .padding(50)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            setTimertext()
            let totalSeconds = Float(minutes * 60 + seconds)
            step = totalSeconds > 0 ? 1 / totalSeconds : 0
        }
    }
    func setTimertext(){
        var minString: String = ""
        var secString: String = ""
        if minRemain < 10 {
            if minRemain == 0 {
                minString = "\(minRemain)"
            }
            else {
                minString = "0\(minRemain)"
            }
        }
        else {
            minString = "\(minRemain)"
        }
        if secRemain < 10 {
            secString = "0\(secRemain)"
        }
        else {
            secString = "\(secRemain)"
        }
        timerText = minString + ":" + secString
    }
    func setResetsession(){
        resetSession = false
        minRemain = minutes
        secRemain = seconds
    }
    func updateProgress(){
        progress += step
    }
}

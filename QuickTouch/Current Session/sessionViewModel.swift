//
//  GameViewModel.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-12.
//

import Foundation
import Combine
import SwiftUI


class sessionViewModel: ObservableObject {
    @Published var sessionMin : Int = 0
    @Published var sessionSec : Int = 0
    @Published var reset : Bool = false
    @Published var play : Bool = true
    @Published var cancel : Bool = false
    @Published var draftSession : Bool = false
    @Published var startSession : Bool = false
    @Published var endSession : Bool = false
    @Published var timerText: String = ""
    @Published var intervalColor : [Color] = []
    @Published var availableColors: [(name: String, color: Color)] = [
        ("Red", .red),
        ("Blue", .blue),
        ("Green", .green),
        ("Yellow", .yellow),
        ("Orange", .orange),
        ("Purple", .purple)
    ]
    @Published var isIntervalSession = false
    @Published var progress: Float = 0.0
    @Published var timerCancellable: AnyCancellable?
    @Published var timerAlert = false
    @Published var colorAlert = false
    private var initialMin : Int = 0
    private var initialSec : Int = 0
    private var step: Float = 0.0
    private var tickCount = 0
    
    func setTimertext(){
        let secString = sessionSec < 10 ? "0\(sessionSec)" : "\(sessionSec)"
        timerText = "\(sessionMin):\(secString)"
    }
    
    func updateProgress(){
        progress += (step / 10)
    }
    
    func saveTime(){
        initialMin = sessionMin
        initialSec = sessionSec
    }
    
    func setupTimer() {
        let totalSeconds = Float(sessionMin * 60 + sessionSec)
        step = totalSeconds > 0 ? 1 / totalSeconds : 0
        progress = 0
        setTimertext()
        // ✅ Add 1-second delay before starting timer
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.timerCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.onTimerTick()
                }
        }
    }
    
    
//    func setupTimer(){
//        let totalSeconds = Float(sessionMin * 60 + sessionSec)
//        step = totalSeconds > 0 ? 1 / totalSeconds : 0
//        progress = 0
//        setTimertext()
//        timerCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
//            .autoconnect()
//            .sink { [weak self] _ in
//                self?.onTimerTick()
//            }
//    }
    
    func decrementTime(){
        if sessionMin == 0 && sessionSec == 0 {
            return // Safely exit if both minute and second are 0
        }
        else if sessionSec > 0 {
            sessionSec -= 1
        }
        else if sessionMin > 0 {
            sessionMin -= 1
            sessionSec = 59
        }
        setTimertext()
    }
    
    private func onTimerTick(){
        if play {
            tickCount += 1
            if tickCount == 10 {
                tickCount = 0
                decrementTime()
                checkCompletion()
            }
            updateProgress()
        }
    }
    
    func checkCompletion(){
        if sessionMin == 0 && sessionSec == 0 {
            timerCancellable?.cancel()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.endSession = true
            }
        }
    }
    
    func cancelSession(){
        cancel = true
    }
    
    func resetSession(){
        sessionMin = initialMin
        sessionSec = initialSec
        endSession = false
        play = true
        setupTimer()
    }
    
    func resetModel(){
        progress = 0.0
        sessionMin = 0
        sessionSec = 0
        reset = false
        play = true
        cancel = false
        draftSession = false
        startSession = false
        endSession  = false
        timerText = ""
        timerCancellable?.cancel()
        timerCancellable = nil
        intervalColor = []
        isIntervalSession = false
        availableColors = [
            ("Red", .red),
            ("Blue", .blue),
            ("Green", .green),
            ("Yellow", .yellow),
            ("Orange", .orange),
            ("Purple", .purple)
        ]
    }
    
    func draftAlert(){
        if sessionMin == 0 && sessionSec == 0 {
            timerAlert = true
        }
        else if isIntervalSession, intervalColor.count < 2 {
            colorAlert = true
        }
        else {
            startSession = true
        }
    }
    
    func makeSession(){
        resetModel()
    }
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

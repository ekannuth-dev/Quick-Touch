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
    @Published var sessionMin: Int = 0
    @Published var sessionSec: Int = 0
    @Published var play: Bool = false
    @Published var timerText: String = ""
    @Published var intervalColor: [Color] = []
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
    @Published var cache: Bool = false
    @Published var showCompletionAlert = false
    @Published var timerCancellable: AnyCancellable?
    @Published var initialMin: Int = 0
    @Published var initialSec: Int = 0
    @Published var step: Float = 0.0
    @Published var tickCount = 0
    
    var onSessionComplete: (() -> Void)?
    
    init(onSessionComplete: (() -> Void)? = nil) {
        self.onSessionComplete = onSessionComplete
    }
    
    func setTimertext() {
        let secString = sessionSec < 10 ? "0\(sessionSec)" : "\(sessionSec)"
        timerText = "\(sessionMin):\(secString)"
    }
    
    func updateProgress() {
        progress += (step / 10)
    }
    
    func saveTime() {
        sessionMin = initialMin
        sessionSec = initialSec
    }
    
    func setupTimer() {
        if !play {
            saveTime()
            setTimertext()
            progress = 0
            let totalSeconds = Float(sessionMin * 60 + sessionSec)
            step = totalSeconds > 0 ? (1 / totalSeconds) : 0
        }
        timerCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.onTimerTick()
            }
    }
    
    func decrementTime() {
        if sessionMin == 0 && sessionSec == 0 {
            onSessionComplete?()
            saveTime()
            resetSession()
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
    
    func onTimerTick() {
        if play {
            tickCount += 1
            if tickCount == 10 {
                tickCount = 0
                decrementTime()
            }
            updateProgress()
        }
    }
    
    func resetSession() {
        play = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setupTimer()
        }
    }
    
    func resetModel() {
        progress = 0.0
        sessionMin = 0
        sessionSec = 0
        play = true
        timerText = ""
        timerCancellable?.cancel()
        timerCancellable = nil
        intervalColor = []
        isIntervalSession = false
        availableColors = [
            ("Red", Color.red),
            ("Blue", Color.blue),
            ("Green", Color.green),
            ("Yellow", Color.yellow),
            ("Orange", Color.orange),
            ("Purple", Color.purple)
        ]
    }
    
    func makeSession() {
        resetModel()
    }
    
    var formattedTime: String {
        return "\(sessionMin):\(sessionSec)"
    }
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

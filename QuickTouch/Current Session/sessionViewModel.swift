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
    @Published var sampleSession: sessionModel
    
    init(sampleSession: sessionModel, onSessionComplete: (() -> Void)? = nil) {
        self.sampleSession = sampleSession
        self.onSessionComplete = onSessionComplete
    }
    
    var onSessionComplete: (() -> Void)?
    
    // MARK: - Timer Properties
    var sessionMin: Int {
        get { sampleSession.sessionMin }
        set { 
            sampleSession.sessionMin = newValue
            objectWillChange.send()
        }
    }
    
    var sessionSec: Int {
        get { sampleSession.sessionSec }
        set { 
            sampleSession.sessionSec = newValue
            objectWillChange.send()
        }
    }
    
    var timerText: String {
        get { sampleSession.timerText }
        set { 
            sampleSession.timerText = newValue
            objectWillChange.send()
        }
    }
    
    var progress: Float {
        get { sampleSession.progress }
        set { 
            sampleSession.progress = newValue
            objectWillChange.send()
        }
    }
    
    // MARK: - Session Control Properties
    var play: Bool {
        get { sampleSession.play }
        set { 
            sampleSession.play = newValue
            objectWillChange.send()
        }
    }
    
    var isIntervalSession: Bool {
        get { sampleSession.isIntervalSession }
        set { 
            sampleSession.isIntervalSession = newValue
            objectWillChange.send()
        }
    }
    
    // MARK: - Color Properties
    var intervalColor: [Color] {
        get { sampleSession.intervalColor }
        set { 
            sampleSession.intervalColor = newValue
            objectWillChange.send()
        }
    }
    
    var availableColors: [(name: String, color: Color)] {
        get { sampleSession.availableColors }
        set { 
            sampleSession.availableColors = newValue
            objectWillChange.send()
        }
    }
    
    // MARK: - Initial Time Properties
    var initialMin: Int {
        get { sampleSession.initialMin }
        set { 
            sampleSession.initialMin = newValue
            objectWillChange.send()
        }
    }
    
    var initialSec: Int {
        get { sampleSession.initialSec }
        set { 
            sampleSession.initialSec = newValue
            objectWillChange.send()
        }
    }
    
    // MARK: - Internal Properties
    private var step: Float {
        get { sampleSession.step }
        set { 
            sampleSession.step = newValue
            objectWillChange.send()
        }
    }
    
    private var tickCount: Int {
        get { sampleSession.tickCount }
        set { 
            sampleSession.tickCount = newValue
            objectWillChange.send()
        }
    }
    
    // MARK: - Timer Management
    var timerCancellable: AnyCancellable? {
        get { sampleSession.timerCancellable }
        set { 
            sampleSession.timerCancellable = newValue
            objectWillChange.send()
        }
    }
    
    func setTimertext() {
        let secString = sampleSession.sessionSec < 10 ? "0\(sampleSession.sessionSec)" : "\(sampleSession.sessionSec)"
        sampleSession.timerText = "\(sampleSession.sessionMin):\(secString)"
        objectWillChange.send()
    }
    
    func updateProgress() {
        sampleSession.progress += (sampleSession.step / 10)
        objectWillChange.send()
    }
    
    func saveTime() {
        sampleSession.sessionMin = sampleSession.initialMin
        sampleSession.sessionSec = sampleSession.initialSec
        objectWillChange.send()
    }
    
    func setupTimer() {
        if sampleSession.play != true {
            saveTime()
            setTimertext()
            sampleSession.progress = 0
            let totalSeconds = Float(sampleSession.sessionMin * 60 + sampleSession.sessionSec)
            sampleSession.step = totalSeconds > 0 ? (1 / totalSeconds) : 0
            objectWillChange.send()
        }
        sampleSession.timerCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.onTimerTick()
            }
    }
    
    func decrementTime() {
        if sampleSession.sessionMin == 0 && sampleSession.sessionSec == 0 {
            onSessionComplete?()
            saveTime()
            self.resetSession()
        }
        else if sampleSession.sessionSec > 0 {
            sampleSession.sessionSec -= 1
        }
        else if sampleSession.sessionMin > 0 {
            sampleSession.sessionMin -= 1
            sampleSession.sessionSec = 59
        }
        setTimertext()
        objectWillChange.send()
    }
    
    func onTimerTick() {
        if sampleSession.play {
            sampleSession.tickCount += 1
            if sampleSession.tickCount == 10 {
                sampleSession.tickCount = 0
                decrementTime()
            }
            updateProgress()
        }
    }
    
    func resetSession() {
        sampleSession.play = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setupTimer()
        }
        objectWillChange.send()
    }
    
    func resetModel() {
        sampleSession.progress = 0.0
        sampleSession.sessionMin = 0
        sampleSession.sessionSec = 0
        sampleSession.play = true
        sampleSession.timerText = ""
        sampleSession.timerCancellable?.cancel()
        sampleSession.timerCancellable = nil
        sampleSession.intervalColor = []
        sampleSession.isIntervalSession = false
        sampleSession.availableColors = [
            ("Red", Color.red),
            ("Blue", Color.blue),
            ("Green", Color.green),
            ("Yellow", Color.yellow),
            ("Orange", Color.orange),
            ("Purple", Color.purple)
        ]
        objectWillChange.send()
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

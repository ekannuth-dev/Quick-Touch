//
//  GameViewModel.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-12.
//

import Foundation
import Combine


class sessionViewModel: ObservableObject {
    @Published var sessionMin : Int = 0
    @Published var sessionSec : Int = 0
    @Published var sessionInterval : Int = 0
    @Published var reset : Bool = false
    @Published var play : Bool = true
    @Published var cancel : Bool = false
    @Published var endSession : Bool = false
    @Published var timerText: String = ""
    @Published var progress: Float = 0.0
    @Published var timerCancellable: AnyCancellable?
    private var step: Float = 0.0
    private var initialMin : Int = 0
    private var initialSec : Int = 0

    func setTimertext(){
   //     let minString = sessionMin < 10 ? "0\(sessionMin)" : "\(sessionMin)"
        let secString = sessionSec < 10 ? "0\(sessionSec)" : "\(sessionSec)"
        timerText = "\(sessionMin):\(secString)"
    }
    func updateProgress(){
        progress += step
    }
    func saveTime(){
        initialMin = sessionMin
        initialSec = sessionSec
    }
    func setupTimer() {
        let totalSeconds = Float(sessionMin * 60 + sessionSec)
        step = totalSeconds > 0 ? 1 / totalSeconds : 0
        // Set the initial timer text
        setTimertext()
        // Setup a timer publisher
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.onTimerTick()
                print("fired timer")// Handle the timer tick every second
            }
    }
    
    func decrementTime() {
            if sessionSec > 0 {
                sessionSec -= 1
            } else if sessionMin > 0 {
                sessionMin -= 1
                sessionSec = 59
            }
            setTimertext()
    }
    
    private func onTimerTick() {
            if reset {
                if progress <= 0 {
                    setResetsession()
                } else {
                    progress -= step
                }
            } else if play {
                decrementTime()
                checkCompletion()
                updateProgress()
            }
    }
    func checkCompletion() {
        if sessionMin == 0 && sessionSec == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.endSession = true
            }
        }
    }
    
    func setResetsession() {
        reset = true
        sessionMin = initialMin
        sessionSec = initialSec
        setTimertext()
    }
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

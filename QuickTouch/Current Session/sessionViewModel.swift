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
    var step: Float = 0.0
    var initialMin : Int = 0
    var initialSec : Int = 0

    func setTimertext(){
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
    
    func setupTimer(){
        let totalSeconds = Float(sessionMin * 60 + sessionSec)
        step = totalSeconds > 0 ? 1 / totalSeconds : 0
        progress = 0
        setTimertext()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.onTimerTick()
            }
    }
    
    func decrementTime(){
            if sessionMin == 0 && sessionSec == 0 {
                return // Safely exit if both minute and second are 0
            }
            if sessionSec > 0 {
                sessionSec -= 1
            } else if sessionMin > 0 {
                sessionMin -= 1
                sessionSec = 59
            }
            setTimertext()
            updateProgress()
    }
    
    private func onTimerTick(){
            if reset {
                progress = 0
                setResetsession()
            } else if play {
                decrementTime()
                checkCompletion()
            }
    }
    
    func checkCompletion(){
        if sessionMin == 0 && sessionSec == 0 {
            timerCancellable?.cancel()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.endSession = true
            }
        }
    }
    
    func cancelSession(){
        cancel = true
    }
    
    func setResetsession(){
        sessionMin = initialMin
        sessionSec = initialSec
        setupTimer()
    }
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

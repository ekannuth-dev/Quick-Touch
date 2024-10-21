//
//  GameViewModel.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-12.
//

import Foundation


class sessionViewModel: ObservableObject {
    @Published var sessionMin : Int = 0
    @Published var sessionSec : Int = 0
    @Published var onValid : Bool = false
    @Published var sessionInterval : Int = 0
    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

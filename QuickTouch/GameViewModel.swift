//
//  GameViewModel.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-12.
//

import Foundation


class GameViewModel: ObservableObject {
    @Published var sessionTotal : Int = 1
    @Published var valid : Bool = false
    @Published var sessionInterval : Int = 0
    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

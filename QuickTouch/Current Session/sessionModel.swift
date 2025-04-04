//
//  sessionModel.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-04-04.
//
import SwiftUI
import Foundation
import Combine


class sesssionModel : ObservableObject {
    @Published var sessionMin : Int = 0
    @Published var sessionSec : Int = 0
    @Published var play : Bool = false
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
    @Published var cache : Bool = false
    @Published var showCompletionAlert = false
    var initialMin : Int = 0
    var initialSec : Int = 0
    private var step: Float = 0.0
    private var tickCount = 0
}

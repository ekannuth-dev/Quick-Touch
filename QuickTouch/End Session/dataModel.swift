//
//  dataModel.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-26.
//


import Foundation
import SwiftUI
import SwiftData


@Model
class SessionData {
    var name: String
    var date: Date

    init(name: String = "Completed Session", date: Date = Date()) {
        self.name = name
        self.date = date
    }
}

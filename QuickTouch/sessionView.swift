//
//  SessionView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-27.
//

import Foundation
import SwiftUI


struct sessionView: View {
    @ObservedObject var sessionDraft : draftViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        Text("\(sessionDraft.sessionSec)")
            .onReceive(timer) { _ in
                if sessionDraft.sessionSec > 0 {
                    sessionDraft.sessionSec -= 1
                }
            }
            .navigationBarBackButtonHidden(true)
        Text("\(timer)")
    }
}

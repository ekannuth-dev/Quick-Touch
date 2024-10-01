//
//  SessionView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-27.
//

import Foundation
import SwiftUI

struct sessionView: View {
    @ObservedObject var sessionDraft: sessionViewModel
    @State var resetSession : Bool = false
    var body: some View {
        NavigationStack {
            VStack{
                if sessionDraft.sessionMin > 0 || sessionDraft.sessionSec > 0 {
                    circularTimer(minutes: sessionDraft.sessionMin, seconds: sessionDraft.sessionSec)
                }
                resetSession = true
            }.navigationDestination(isPresented: $resetSession){
                resetSessionView()
            }
        }
    }
}

#Preview {
    sessionView(sessionDraft: sessionViewModel())
}


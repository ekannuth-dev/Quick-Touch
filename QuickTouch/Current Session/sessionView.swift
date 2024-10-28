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
    @State var reset : Bool = false
    @State var play : Bool = true
    var body: some View {
        NavigationStack {
            VStack {
                circularTimer(minutes: sessionDraft.sessionMin, seconds: sessionDraft.sessionSec, minRemain: sessionDraft.sessionMin, secRemain:  sessionDraft.sessionSec, reset: $reset)
            }.navigationDestination(isPresented: $reset){
                endSessionView(lastSession: sessionDraft)
            .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    sessionView(sessionDraft: sessionViewModel())
}


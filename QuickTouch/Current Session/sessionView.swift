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
                circularTimer(minutes: sessionDraft.sessionMin, seconds: sessionDraft.sessionSec, resetSession: $reset, playSession: $play)
            }.navigationDestination(isPresented: $reset){
                resetSessionView(lastSession: sessionDraft)
            .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    sessionView(sessionDraft: sessionViewModel())
}


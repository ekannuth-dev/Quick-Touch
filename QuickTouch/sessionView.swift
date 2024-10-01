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
                circularTimer(minutes: $sessionDraft.sessionMin, seconds: $sessionDraft.sessionSec, resetSession: $resetSession)
            }.navigationDestination(isPresented: $resetSession){
                resetSessionView()
            .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    sessionView(sessionDraft: sessionViewModel())
}


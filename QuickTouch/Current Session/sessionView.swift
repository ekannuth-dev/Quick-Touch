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
    var body: some View {
        NavigationStack {
            VStack {
              //  sessionDraft.saveTime()
                circularTimer(currentSession: sessionDraft)
            }.navigationDestination(isPresented: $sessionDraft.reset){
                endSessionView(lastSession: sessionDraft)
            .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    sessionView(sessionDraft: sessionViewModel())
}


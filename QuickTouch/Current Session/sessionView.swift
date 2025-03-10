//
//  SessionView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-27.
//

import SwiftUI
import SwiftData

struct SessionView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var sessionDraft: sessionViewModel
    @Query private var sessions: [SessionData]
    @StateObject private var viewModel = sessionViewModel()
    
    var body: some View {
        VStack {
            circularTimer(currentSession: sessionDraft)
                .onAppear {
                    sessionDraft.onSessionComplete = {
                        let completedSession = SessionData()
                        context.insert(completedSession)
                        viewModel.showCompletionAlert = true
                    }
                }
            .alert("Congratulations! 🎉", isPresented: $viewModel.showCompletionAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("You've successfully completed your session!")
            }
        }
    }
}

#Preview {
   SessionView(sessionDraft: sessionViewModel())
}


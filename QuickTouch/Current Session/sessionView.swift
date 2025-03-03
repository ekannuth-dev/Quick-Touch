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
    @Query private var sessions: [SessionData]  // Add this line to check sessions
    
    var body: some View {
        VStack {
            // Debug text to show current count
            circularTimer(currentSession: sessionDraft)
                .onAppear {
                    sessionDraft.onSessionComplete = {
                        let completedSession = SessionData()
                        context.insert(completedSession)
                    //    try? context.save()  // Make sure to save t
                    }
                }
        }
    }
}

#Preview {
   SessionView(sessionDraft: sessionViewModel())
}


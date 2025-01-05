//
//  resetSessionView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-30.
//

import Foundation
import SwiftUI


struct endSessionView: View {
    @ObservedObject var lastSession: sessionViewModel
    @State private var changeSession = false
    var body: some View {
            VStack {
                Text("Amazing Session")
                    .font(.largeTitle)
                    .padding()
                Button(action: {
                            lastSession.setResetsession()
                            changeSession = true
                        }) {
                            Text("Restart same session?")
                        }
                Text("Create a new session?")
            }
            .navigationDestination(isPresented: $changeSession){
                sessionView(sessionDraft: lastSession)
                .navigationBarBackButtonHidden(true)
            }
    }
}

#Preview {
    endSessionView(lastSession: sessionViewModel())
}



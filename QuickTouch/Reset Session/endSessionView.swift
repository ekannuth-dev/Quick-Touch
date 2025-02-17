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
    var body: some View {
        VStack {
            Text("Amazing Session")
                .font(.largeTitle)
                .padding()
            Button(action: {
                if lastSession.isIntervalSession {
                    lastSession.resetIntervalSession()
                }
                else {
                    lastSession.resetSession()
                }
            }) {
                Text("Restart the same session?")
            }
            .padding()
            Button(action: {
                lastSession.makeSession()
                })
            {
                Text("Create a new session?")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    endSessionView(lastSession: sessionViewModel())
//}



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
        NavigationStack {
            VStack {
                Text("Amazing Session")
                    .font(.largeTitle)
                    .padding()
                NavigationLink {
                    draftView(draftModel: lastSession)
                }
                label: {
                    Text("Create a new Session?")
                }
                .padding()
                NavigationLink {
                   sessionView(sessionDraft: lastSession)
                }
                label:
                {
                    Text("Restart the same session?")
                }
            }
        }
    }
}

#Preview {
    endSessionView(lastSession: sessionViewModel())
}



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
    @Binding var path: NavigationPath
    var body: some View {
            VStack {
                circularTimer(currentSession: sessionDraft)
            }
            .onChange(of: sessionDraft.endSession) {
                    path.append(Destination.endSessionView)
            }
        .navigationDestination(for: Destination.self) {_ in
            endSessionView(lastSession: sessionDraft, path: $path)
        }
    }
}

//#Preview {
//    sessionView(sessionDraft: sessionViewModel())
//}


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
            circularTimer(currentSession: sessionDraft)
    }
}

#Preview {
   sessionView(sessionDraft: sessionViewModel())
}


//
//  settingSession.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-21.
//

import SwiftUI

struct SettingSession: View {
    @ObservedObject var draftModel: sessionViewModel
    @State private var activeAlert: SessionAlerts?
    @State private var showInfoPopup = false // ✅ State to show explanation pop-up

    var body: some View {
        VStack {
            TimerView(draftSession: draftModel)
            intervalView(draftModel: draftModel)
            HStack {
                Text("Enable Interval Session")
                    .font(.body)
                    .layoutPriority(1)
                
                Button(action: {
                    showInfoPopup = true // ✅ Show pop-up
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.body)
                }

                Spacer() // Pushes toggle to the right
                
                Toggle("", isOn: Binding(
                    get: { draftModel.isIntervalSession },
                    set: { newValue in
                        if newValue {
                            if draftModel.initialMin == 0 && draftModel.initialSec == 0 {
                                activeAlert = .zeroTimeAlert
                            }
                            else if draftModel.intervalColor.count < 2 {
                                activeAlert = .colorAlert
                            }
                            else {
                                draftModel.isIntervalSession = newValue
                            }
                        } else {
                            draftModel.isIntervalSession = false
                        }
                    }
                ))
            }
            .padding(.horizontal)
        }
        .alert("What is an Interval Session?", isPresented: $showInfoPopup) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("An interval session is a training mode that alternates between different colors at timed intervals, helping athletes improve reaction time and focus.")
        }
        .alert(item: $activeAlert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: draftModel.intervalColor.count) { oldCount, count in
            if count < 2 && draftModel.isIntervalSession {
                draftModel.isIntervalSession = false
            }
        }
    }
}

//
//  settingSession.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-21.
//
import SwiftUI
import Foundation


struct SettingSession: View {
    @ObservedObject var draftModel: sessionViewModel
    @State private var activeAlert: SessionAlerts?
    
    var body: some View {
        VStack {
            TimerView(draftSession: draftModel)
            intervalView(draftModel: draftModel)
            Toggle("Enable Interval Session", isOn: Binding(
                get: { draftModel.isIntervalSession },
                set: { newValue in
                    if newValue {
                        // Checks when trying to enable interval session
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
                        // When turning off interval session
                        draftModel.isIntervalSession = false
                    }
                }
            ))
        }
        .alert(item: $activeAlert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        // Add observer for intervalColor count changes
        .onChange(of: draftModel.intervalColor.count) {oldCount, count in
            if count < 2 && draftModel.isIntervalSession {
                draftModel.isIntervalSession = false
            //    activeAlert = .colorAlert
            }
        }
    }
}

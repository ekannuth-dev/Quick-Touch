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
            Toggle("Enable Interval Session", isOn: Binding (
                get: { draftModel.isIntervalSession },
                set: { newValue in
                    if newValue && draftModel.initialMin == 0 && draftModel.initialSec == 0 {
                        activeAlert = .zeroTimeAlert
                    } else {
                        draftModel.isIntervalSession = newValue
                    }
                }
            ))
            if draftModel.isIntervalSession {
                intervalView(draftModel: draftModel)
            }
        }
        .alert(item: $activeAlert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

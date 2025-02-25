//
//  ContentView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-04.
//

import SwiftUI
import Observation


struct tabView: View {
    @StateObject var sessionModel = sessionViewModel()
    @State var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab){
            sessionView(sessionDraft: sessionModel)
                .tabItem {
                    Image(systemName: "timer")
                    Text("Session")
                }
                .tag(1)
            settingView(draftModel: sessionModel)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}

#Preview {
    tabView()
}

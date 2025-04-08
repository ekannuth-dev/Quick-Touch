//
//  ContentView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-04.
//

import SwiftUI
import Observation


struct tabView: View {
    @StateObject private var currentModel = sessionViewModel()
    @State var selectedTab = 1
    let item = SessionData()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                DataView()
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Data")
            }
            .tag(0)
            
            SessionView(sessionDraft: currentModel)
                .tabItem {
                    Image(systemName: "timer")
                    Text("Session")
                }
                .tag(1)
            
            settingView(draftModel: currentModel)
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

//
//  ContentView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-04.
//

import SwiftUI
import Observation


struct mainView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Quick Touch")
                    .font(.largeTitle)
                    .padding()
                NavigationLink {
                    draftView()
                } label:
                {
                    Text("Begin Session")
                }
            }
        }
    }
}

#Preview {
    mainView()
}
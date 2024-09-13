//
//  ContentView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-04.
//

import SwiftUI
import Observation


struct ContentView: View {
    @State var setView = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Quick Touch")
                    .font(.largeTitle)
                    .padding()
                Button(action: {
                    setView = true
                })
                {
                    Text("Click to Play")
                }
            }
            .navigationDestination(isPresented: $setView){
                GameView()
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-04.
//

import SwiftUI
import Observation


struct mainView: View {
    @StateObject var sessionModel = sessionViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text("Quick Touch")
                    .font(.largeTitle)
                    .padding()
                NavigationLink("Begin Session"){
                    draftView(draftModel: sessionModel)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    mainView()
}

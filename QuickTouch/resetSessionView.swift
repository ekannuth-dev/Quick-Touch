//
//  resetSessionView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-30.
//

import Foundation
import SwiftUI


struct resetSessionView: View {
    @State var setView : Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Amazing Session")
                    .font(.largeTitle)
                    .padding()
                Button(action: {
                    setView = true
                })
                {
                    Text("Create a new Session?")
                }
            }
            .navigationDestination(isPresented: $setView){
                draftView()
            }
        }
    }
}


#Preview {
    resetSessionView()
}

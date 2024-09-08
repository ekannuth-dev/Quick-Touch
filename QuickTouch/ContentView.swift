//
//  ContentView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-04.
//

import SwiftUI

enum Images: String {
    case Red = "Red"
    case Blue = "Blue"
    case Yellow = "Yellow"
    case Green = "Green"
}

struct ContentView: View {
    func buttonTapped(){
        print("Hello")
    }
    var body: some View {
        VStack{
            Text("Quick Touch")
                .font(.largeTitle)
            Button(action: {
                buttonTapped()
            })
            {
                Text("Click to Play")
            }
        }
    }
}

#Preview {
    ContentView()
}

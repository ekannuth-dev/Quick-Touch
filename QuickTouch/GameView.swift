//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct GameView: View {
    @State private var input : Int = 0
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var valid : Bool = false
    var body: some View {
        NavigationStack {
            VStack {
              //      let _ = print(input)
                Text("\(input)")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                TextField("Enter a number", value: $input, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                HStack {
                    Button("Start Timer"){
                        valid = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    Button("Stop Timer"){
                        valid = false
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
                 //   let _ = print(input)
            }
            .onReceive(timer, perform: { firedDate in
                if valid {
                    input -= 1
                }
            })
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Game View")
    }
}


#Preview {
    GameView()
}

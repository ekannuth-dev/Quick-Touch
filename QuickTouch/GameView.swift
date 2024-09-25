//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    @State private var timerCount = 0
    var body: some View {
        NavigationStack {
            VStack {
                //      let _ = print(input)
                Form{
                    HStack{
                        Text("Session Length")
                        Picker("Select Timer", selection: $viewModel.sessionTotal){
                            ForEach(1...59, id: \.self) {num in
                                Text("\(num)")
                            }
                        }.pickerStyle(.wheel)
                            .padding()
                        Text("Intervals")
                        Picker("Intervals", selection: $viewModel.sessionInterval){
                            ForEach(0...10, id: \.self) {num in
                                Text("\(num)")
                            }
                        }.pickerStyle(.wheel)
                    }
                    Button("Start Session"){
                        let _ = print($viewModel.sessionTotal)
                    }
                    .navigationTitle("Create Session")
                    //   let _ = print(input)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Game View")
        }
    }
}


#Preview {
    GameView()
}

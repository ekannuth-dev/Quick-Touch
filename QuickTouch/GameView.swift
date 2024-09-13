//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct GameView: View {
    @ObservedObject var viewModel = GameViewModel()
    @State private var sampleUser: userProfile?
    var body: some View {
        NavigationStack {
            VStack {
                Text(sampleUser?.avatarUrl ?? "Display Username")
                Text("\(sampleUser?.followers ?? 5) followers")
                Text("\(sampleUser?.following ?? 5) following")
                //      let _ = print(input)
                Text("\(viewModel.input)")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                TextField("Enter a number", value: $viewModel.input, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                HStack {
                    Button("Start Timer"){
                        viewModel.valid = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    Button("Stop Timer"){
                        viewModel.valid = false
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
                //   let _ = print(input)
            }
            .onReceive(viewModel.timer, perform: { firedDate in
                if viewModel.valid {
                    viewModel.decrement()
                }
            })
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Game View")
        .task {
            do {
                try await sampleUser = viewModel.getUser()
            }
            catch {
                print("error")
            }
        }
    }
}


#Preview {
    GameView()
}

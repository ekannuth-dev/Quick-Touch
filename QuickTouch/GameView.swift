//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct GameView: View {
    @State private var input = 0
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter a number", value: $input, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Game View")
            InputView(timer: input)
        }
    }
}


#Preview {
    GameView()
}

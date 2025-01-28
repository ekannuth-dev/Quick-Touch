//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct draftView: View {
    @StateObject var draftModel = sessionViewModel()
    @State private var start : Bool = false
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            VStack {
                Form {
                    Section {
                        HStack{
                            TimerView(draftSession: draftModel)
                        }
                    }
                    Section{
                        HStack{
                            Text("Interval Seconds:")
                            TextField("Enter Seconds", value: $draftModel.sessionInterval, formatter: NumberFormatter())
                                .frame(height: 50)
                        }
                    }
                    Section {
                        HStack {
                            Button("Start Session"){
                                path.append(Destination.sessionView)
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                    }
                }
            }
            .navigationTitle("Create Session")
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: Destination.self){_ in
                sessionView(sessionDraft: draftModel, path: $path)
            }
        }
    }
}


#Preview {
    let mockModel = sessionViewModel() // Create a mock model with sample data
    draftView(draftModel: mockModel) // Pass the mock model to the view
}

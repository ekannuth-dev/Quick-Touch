//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct draftView: View {
    @ObservedObject var draftModel : sessionViewModel
    var body: some View {
        NavigationStack(){
            VStack {
                Form {
                    Section {
                        HStack {
                            TimerView(draftSession: draftModel)
                        }
                    }
                    Section {
                        Toggle("Enable Interval Session", isOn: $draftModel.isIntervalSession)
                    }
                    
                    if draftModel.isIntervalSession {
                        intervalView(draftModel: draftModel)
                    }
                    
                    Section {
                        HStack {
                            Button("Start Session"){
                                draftModel.draftAlert()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .alert("Invalid Time", isPresented: $draftModel.timerAlert){
                                Button("OK", role: .cancel){}
                            } message: {
                                Text("Please select a valid time greater than 0.")
                            }
                            .alert("Invalid Color Selection", isPresented: $draftModel.colorAlert){
                                Button("OK", role: .cancel){}
                            } message: {
                                Text("Please select at least two colors")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                    }
                }
            }
            .navigationTitle("Create Session")
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $draftModel.startSession){
                sessionView(sessionDraft: draftModel)
            }
        }
    }
}


#Preview {
    let mockModel = sessionViewModel() // Create a mock model with sample data
    draftView(draftModel: mockModel) // Pass the mock model to the view
}

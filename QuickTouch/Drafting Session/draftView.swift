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
    @State private var showAlert = false
    var body: some View {
        NavigationStack(){
            VStack {
                Form {
                    Section {
                        HStack{
                            TimerView(draftSession: draftModel)
                        }
                    }
                    Section {
                        HStack{
                            Text("Interval Seconds:")
                            TextField("Enter Seconds", value: $draftModel.sessionInterval, formatter: NumberFormatter())
                                .frame(height: 50)
                        }
                    }
                    Section {
                        HStack {
                            Button("Start Session"){
                                if draftModel.sessionMin == 0 && draftModel.sessionSec == 0 {
                                    showAlert = true
                                }
                                else {
                                    draftModel.startSession = true
                                }
                            }
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .alert("Invalid Time", isPresented: $showAlert) {
                                Button("OK", role: .cancel){}
                            } message: {
                                Text("Please select a valid time greater than 0.")
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

//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct draftView: View {
    @ObservedObject var draftModel: sessionViewModel
    var body: some View {
        NavigationStack {
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
                        HStack{
                            NavigationLink {
                                sessionView(sessionDraft: draftModel)
                            } label:
                            {
                                Text("Start Session")
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
        }
        .navigationBarBackButtonHidden(true)
    }
}


//#Preview {
//    draftView(draftModel: <#T##sessionViewModel#>())
//}

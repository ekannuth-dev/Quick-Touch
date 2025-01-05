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
    @State private var path : [any View] = []
    var body: some View {
        NavigationStack(path: <#T##Binding<NavigationPath>#>) {
            VStack {
                Form {
//                    path.append(TimerView(draftSession: draftModel))
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
        }
        .navigationTitle("Create Session")
        .navigationBarBackButtonHidden(true)
    }
}


//#Preview {
//    draftView(draftModel: <#T##sessionViewModel#>())
//}

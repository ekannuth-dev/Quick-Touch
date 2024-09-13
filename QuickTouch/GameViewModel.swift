//
//  GameViewModel.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-12.
//

import Foundation


class GameViewModel: ObservableObject {
    @Published var input : Int = 0
    @Published var valid : Bool = false
    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @Published var avatarUrl: String = ""
    @Published var followers: Int = 0
    @Published var following: Int = 0
    
    func decrement(){
        input -= 1
    }
    //Display a Profile
    func getUser() async throws -> userProfile {
        let url = URL(string: "https://api.github.com/users/ekannuth-dev")! //turns string url to url object
        let (data, _) = try await URLSession.shared.data(from: url)
      //  let _ = print(data)
     //   let _ = print(response)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let user = try decoder.decode(userProfile.self, from: data) //JSONDecoder uses the type and not the instance
        let _ = print(user)
        return user
    }
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}


struct userProfile: Codable {
    let avatarUrl: String
    let followers: Int
    let following: Int
}

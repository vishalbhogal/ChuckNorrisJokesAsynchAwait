//
//  GeeksJobsViewModel.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 17/04/22.
//

import Foundation
import Combine

class GeeksJokesViewModel: ObservableObject {
    //Internal Properties
    @Published var joke: String = ""
    
    //Private Properties
    private var geeksJokeServiceAPI: GeeksJokeServiceAPIServiceable
    init(geeksJokeService: GeeksJokeServiceAPIServiceable) {
        geeksJokeServiceAPI = geeksJokeService
    }
    
    //Internal Methods
    func fetchJokeFromService() {
        Task {
            let fetchJoke = await geeksJokeServiceAPI.fetchData()
            switch fetchJoke {
            case .failure(let error):
                print("API services are currently unavailable due to \(error.localizedDescription)")
            case .success(let jokesResponse):
                DispatchQueue.main.async {
                    self.joke = jokesResponse.joke
                }
            }
        }
    }
}

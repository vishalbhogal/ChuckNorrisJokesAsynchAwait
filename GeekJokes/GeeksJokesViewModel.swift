//
//  GeeksJobsViewModel.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 17/04/22.
//

import Foundation
import RxSwift
import RxRelay
import Combine

class GeeksJokesViewModel: ObservableObject {
    //Internal Properties
    @Published var joke: String = ""
    
    //Private Properties
    private let disposeBag = DisposeBag()
    private var geeksJokeServiceAPI: GeeksJokeServiceAPIServiceable

    init(geeksJokeService: GeeksJokeServiceAPIServiceable) {
        geeksJokeServiceAPI = geeksJokeService
    }
    
    //Internal Methods
    func fetchJokeFromService() {
       let fetchedResponse = geeksJokeServiceAPI.fetchData()
        fetchedResponse.subscribe(onNext: { jokeResponse in
            DispatchQueue.main.async {
                self.joke = jokeResponse.joke
            }
        }).disposed(by: disposeBag)
    }
}

//
//  GeekJokesServiceAPI.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 16/04/22.
//

import Foundation
import RxSwift
import RxRelay

protocol GeeksJokeServiceAPIServiceable {
    func fetchData() -> Observable<GeekJokesResponseModel>
}

class GeeksJokeServiceAPIService: GeeksJokeServiceAPIServiceable {
    func fetchData() -> Observable<GeekJokesResponseModel> {
        Observable.create { observer in
            var urlRequest = URLRequest(url: URL(string: "https://geek-jokes.sameerkumar.website/api?format=json")!)
            urlRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(GeekJokesResponseModel.self, from: data)
                        observer.onNext(response)
                    }
                    catch {
                        print("UnableToDecode")
                    }
                }
            }
            task.resume()
            return Disposables.create {}
        }
    }
}

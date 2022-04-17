//
//  GeekJokesServiceAPI.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 16/04/22.
//

import Foundation

enum APIErrors: Error {
    case emptyURL
    case corruptData
    case unsuccesfulStatusCode
}

protocol GeeksJokeServiceAPIServiceable {
    func fetchData() async -> Result<GeekJokesResponseModel, Error>
}

class GeeksJokeServiceAPIService: GeeksJokeServiceAPIServiceable {
    func fetchData() async -> Result<GeekJokesResponseModel, Error> {
        let url = URL(string: "https://geek-jokes.sameerkumar.website/api?format=json")
        guard let url = url else {
            return .failure(APIErrors.emptyURL)
        }
    
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return .failure(APIErrors.unsuccesfulStatusCode)
            }
            let geekJokeResponse = try JSONDecoder().decode(GeekJokesResponseModel.self, from: data)
            return .success(geekJokeResponse)
        }
        catch {
            return .failure(APIErrors.corruptData)
        }
        
    }
}

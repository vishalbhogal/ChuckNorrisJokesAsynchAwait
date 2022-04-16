//
//  ContentView.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 16/04/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var geekJokesViewModel = GeeksJokesViewModel(geeksJokeService: GeeksJokeServiceAPIService())

    var body: some View {
        VStack {
            Text(geekJokesViewModel.joke)
                .padding()
                .onAppear {
                    geekJokesViewModel.fetchJokeFromService()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

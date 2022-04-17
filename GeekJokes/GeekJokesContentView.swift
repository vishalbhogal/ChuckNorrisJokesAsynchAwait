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
        ZStack {
            LinearGradient(colors: [.green, .black], startPoint: .topLeading, endPoint: .bottomTrailing)

            VStack(alignment: .center, spacing: 15) {
                Text("Chuck Norris Who??")
                    .font(.system(.title, design: .monospaced))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)

                Image("chuckNorris")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                
                Text(geekJokesViewModel.joke)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.black)
                    .frame(width: 300, height: 200, alignment: .center)
                    .padding()
                    .background(.green)
                    .cornerRadius(10)
                
                Text("Next Fact")
                    .font(.system(.headline, design: .monospaced))
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                    .onTapGesture {
                        geekJokesViewModel.fetchJokeFromService()
                    }
                    .padding(.all, 12)
                
                    .background(.black)
                    .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

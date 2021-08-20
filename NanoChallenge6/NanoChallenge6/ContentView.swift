//
//  ContentView.swift
//  NanoChallenge6
//
//  Created by Lucas Claro on 20/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var guia : GuiaAberta = .Home
    
    var body: some View {
        TabView (selection: $guia){
            Home().tabItem { Image(systemName: "house") }
                .tag(GuiaAberta.Home)
            Guia2().tabItem { Image(systemName: "stop") }
                .tag(GuiaAberta.Guia2)
        }
    }
    
    func Home() -> some View {
        ScrollView {
            VStack {
                //Barra de Pesquisa
                ScrollView(.horizontal) {
                    HStack {
                        Text("Categoria A")
                        Text("Categoria B")
                        Text("Categoria C")
                        Text("Categoria D")
                        Text("Categoria E")
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 150, height: 300)
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 150, height: 300)
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 150, height: 300)
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 150, height: 300)
                    }
                }
            }
        }
    }
    
    func Guia2() -> some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 150, height: 300)
    }
}

enum GuiaAberta : Hashable {
    case Home
    case Guia2
    case Guia3
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

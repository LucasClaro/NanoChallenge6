//
//  ContentView.swift
//  NanoChallenge6
//
//  Created by Lucas Claro on 20/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var guia : GuiaAberta = .Home
    @State var mostrandoItem : Bool = false
    @State var produtoSelecionado : String? = nil
    @State var searchText : String = ""
    @State private var isEditing = false
    
    let produtos = ["ProdutoA","ProdutoB","ProdutoComNomeGradePraTestar","ProdutoD","ProdutoE","ProdutoF","ProdutoG", "ProdutoH"]
    let columns = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40))
    ]
    
    var body: some View {
        TabView (selection: $guia){
            Home().tabItem { Image(systemName: "house") }
                .tag(GuiaAberta.Home)
            Guia2().tabItem { Image(systemName: "stop") }
                .tag(GuiaAberta.Guia2)
        }
    }
    
    func Home() -> some View {
        
        VStack {
            
            SearchBar()
                
                VStack {
                    //Barra de Pesquisa
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("Categoria A")
                            Text("Categoria B")
                            Text("Categoria C")
                            Text("Categoria D")
                            Text("Categoria E")
                        }
                    }
                        .padding()
                    
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach (produtos, id: \.self) { produto in
                                                    
                                if searchText == "" || produto.contains(searchText) {
                                    ZStack {
                                        Image("Teste2")
                                            .resizable()
                                            .frame(minWidth: 200, idealWidth: 200, maxWidth: 200, minHeight: 266, idealHeight: 266, maxHeight: 266, alignment: .center)
                                        VStack {
                                            Image("Teste").resizable()
                                                .frame(minWidth: 150, idealWidth: 150, maxWidth: 150, minHeight: 150, idealHeight: 150, maxHeight: 150, alignment: .center)
                                            Text(produto)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 150, alignment: .center)
                                        }
                                    }
                                        .onTapGesture {
                                            mostrandoItem.toggle()
                                            produtoSelecionado = produto
                                        }
                                        .sheet(isPresented: $mostrandoItem) {
                                            ItemAberto(aberto: $mostrandoItem, itemAberto: $produtoSelecionado)
                                        }
                                }
                            
                            }
                        }
                    }
                }//VStack
        }//VStack

    }
    
    func Guia2() -> some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 150, height: 300)
    }
    
    func SearchBar() -> some View {
        HStack {
         
            TextField("Search ...", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct ItemAberto: View {
    
    @Binding var aberto : Bool
    @Binding var itemAberto : String?
    
    var body: some View {
        Button(itemAberto ?? "Produto") {
                    aberto = false
                    itemAberto = nil
                }
                .font(.title)
                .padding()
                .background(Color.black)
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

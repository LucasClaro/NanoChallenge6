//
//  ContentView.swift
//  NanoChallenge6
//
//  Created by Lucas Claro on 20/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText : String = ""
    @State private var showCancelButton: Bool = false
    
    let produtos = ["ProdutoA","ProdutoB","ProdutoComNomeGradePraTestar","ProdutoD","ProdutoE","ProdutoF","ProdutoG", "ProdutoH"]
    let columns = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40))
    ]
    
    var body: some View {
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
                    
                    ItensList(searchText: $searchText, produtos: produtos)
                    
                }//VStack
        }//VStack
            .resignKeyboardOnDragGesture()
    }
    
    func SearchBar() -> some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("Buscar", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }).foregroundColor(.primary)

                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if showCancelButton  {
                Button("Cancel") {
                        UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                        self.searchText = ""
                        self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton)
    }
}

struct ItensList: View {
    
    @State var mostrandoItem : Bool = false
    @State var produtoSelecionado : String? = nil
    
    @Binding var searchText : String
    var produtos : [String]
    
    let columns = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach (produtos, id: \.self) { produto in
                                        
                    if searchText == "" || produto.contains(searchText) {
                        ZStack {
                            Image("card")
                                .resizable()
                                .frame(minWidth: 200, idealWidth: 200, maxWidth: 200, minHeight: 261, idealHeight: 261, maxHeight: 261, alignment: .center)
                            VStack {
                                Image("Teste").resizable()
                                    .frame(minWidth: 150, idealWidth: 150, maxWidth: 150, minHeight: 150, idealHeight: 150, maxHeight: 150, alignment: .center)
                                Text(produto)
                                    .font(.custom("NewYork-Black", size: 18))
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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

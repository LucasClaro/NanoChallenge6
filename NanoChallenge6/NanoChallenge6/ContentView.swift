//
//  ContentView.swift
//  NanoChallenge6
//
//  Created by Lucas Claro on 20/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText : String = ""
    @State private var showCancelButton: Bool = false
    
    @State private var selectedCategory : String = ""
    
    var body: some View {
        VStack {
            
            SearchBar()
                
                VStack {
                    HStack (alignment: .center) {
                        Spacer()
                        Text("Candies")
                            .padding()
                            .if (selectedCategory == "Candies") { view in
                                view
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                            .onTapGesture {
                                if selectedCategory == "Candies"{
                                    selectedCategory = ""
                                }
                                else {
                                    selectedCategory = "Candies"
                                }
                            }
                        Spacer()
                        Text("Plants")
                            .padding()
                            .if (selectedCategory == "Plants") { view in
                                view
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                            .onTapGesture {
                                if selectedCategory == "Plants"{
                                    selectedCategory = ""
                                }
                                else {
                                    selectedCategory = "Plants"
                                }
                            }
                        Spacer()
                        Text("Jokes")
                            .padding()
                            .if (selectedCategory == "Jokes") { view in
                                view
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                            .onTapGesture {
                                if selectedCategory == "Jokes"{
                                    selectedCategory = ""
                                }
                                else {
                                    selectedCategory = "Jokes"
                                }
                            }
                        Spacer()
                    }
                        .padding()
                    
                    ItensList(searchText: $searchText, selectedCategory: $selectedCategory)
                    
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
    
    let produtosTeste = ["ProdutoA","ProdutoB","ProdutoComNomeGradePraTestar","ProdutoD","ProdutoE","ProdutoF","ProdutoG", "ProdutoH"]
    
    @State private var mostrandoItem : Bool = false
    @State private var produtoSelecionado : Produto? = nil
    
    @Binding var searchText : String
    @Binding var selectedCategory : String
    
    let columns = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach (produtos, id: \.self) { produto in
                                        
                    if (searchText == "" || produto.name.contains(searchText)) && (selectedCategory == "" || produto.category == selectedCategory) {
                        ZStack {
                            Image("card")
                                .resizable()
                                .frame(minWidth: 200, idealWidth: 200, maxWidth: 200, minHeight: 261, idealHeight: 261, maxHeight: 261, alignment: .center)
                            VStack {
                                Image("Teste").resizable()
                                    .frame(minWidth: 150, idealWidth: 150, maxWidth: 150, minHeight: 150, idealHeight: 150, maxHeight: 150, alignment: .center)
                                Text(produto.name)
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
    @Binding var itemAberto : Produto?
    
    var body: some View {
        Button(itemAberto?.name ?? "Produto") {
                    aberto = false
                    itemAberto = nil
                }
                .font(.title)
                .padding()
                .background(Color.black)
    }
}

struct Produto : Hashable {
    var name : String
    var description : String
    var category : String
    var price : String
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

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

let produtos = [
    Produto(name: "Chocolate Frog", description: """
Frog shaped chocolate.
Each frog comes with a collectible card of a famous witch or wizard in each pack.

*Be careful not to let it escape

Ingredients:
70% Croakoa
""", category: "Candies", price: "10"),
    Produto(name: "Bertie Bott's Every Flavor Beans", description: """
One of the most popular sweets in the wizarding world. The range encompassed every flavour imaginable.
""", category: "Candies", price: "6 Sickles per box"),
    Produto(name: "Peppermint Toad", description: """
Magical peppermint cream, shaped like a toad, which hop realistically in the stomach when it is consumed.
""", category: "Candies", price: "10"),
    Produto(name: "Jelly Slugs", description: """
Gummy candies that look like slugs.
""", category: "Candies", price: "10"),
    Produto(name: "Mandrake", description: """
Magical and sentient plant that looks like a human. Roots can be used for various purposes.

*Be careful. Cries are fatal to anyone who hears it.
""", category: "Plants", price: "10"),
    Produto(name: "Puffapod", description: """
Magical plant that produces large pink seedpods full of shining beans, which instantly flowered when they came into contact with any solid object.

*Spores can cause dizziness
""", category: "Plants", price: "10"),
    Produto(name: "Gillyweed", description: """
Magical plant that, when ingested, allows a human to breathe underwater.
""", category: "Plants", price: "10"),
    Produto(name: "Nettle", description: """
Also known as the stinging nettle (Urtica diocia) or burn hazel, is a widespread plant with stinging hairs that grows on its leaves.
""", category: "Plants", price: "10"),
    Produto(name: "Bombastic Bombs", description: """
Disastrous Delights!"

Explosives created by Weasleys' Wizard Wheezes.
""", category: "Jokes", price: "10"),
    Produto(name: "WonderWitch", description: """
Line of Weasleys' Wizard Wheezes products designed and marketed for witches.
Any product that you want can be disguised as ordinary perfume or other such bottled products such as cough potions as a part of the mail order service.
""", category: "Jokes", price: "10"),
    Produto(name: "Jinx-Off", description: """
Spell-protection kit madeby Weasleys' Wizard Wheezes which included a hat, cloak, and gloves.

*All three items had to be worn together for "maximum protection"
*Care should be taken to ensure the set is in perfect condition, as a damaged piece could interfere with the protection.
""", category: "Jokes", price: "The full kit cost four galleons, sixteen sickles and twenty-five knuts."),
    Produto(name: "Weather in a Bottle", description: """
Is a Weasleys' Wizard Wheezes product. It held wind, water or any kind of weather that when unleashed would affect a small area around the bottle.
""", category: "Jokes", price: "10")]

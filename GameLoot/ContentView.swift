//
//  ContentView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import SwiftUI

class Inventory: ObservableObject {
    @Published var loots : [LootItem] = MockData.lootItemsMock
    
    func addItem(item: LootItem) {
        loots.append(item)
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    @State var showAddItemView : Bool = false;
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(inventory.loots, id: \.self) { item in
                    NavigationLink {
                        LootDetailView(item: item)
                        } label: {
                            HStack(alignment: .center, spacing: 3) {
                                Image(systemName: "circle.fill")
                                    .renderingMode(.template)
                                    .foregroundColor(item.rarity.getColor())
                                Text("\(item.type.getEmoji()) \(item.name)")
                            }
                        }
                }
            }
            .sheet(isPresented: $showAddItemView, content: {
                    AddItemView()
                          .environmentObject(inventory)
                })
            .navigationBarTitle("👝 Inventory")
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                    Button(action: {
                        showAddItemView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                }
            })
        }
    }
}
#Preview {
    ContentView()
}

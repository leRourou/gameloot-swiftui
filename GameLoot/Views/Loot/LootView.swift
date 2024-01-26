//
//  InventoryView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/26/24.
//

import SwiftUI

struct LootView: View {
    @Environment(\.editMode) private var editMode
    @State var showAddItemView : Bool = false
    @StateObject var inventory = Inventory()
    
    func deleteLoot(at offsets: IndexSet) {
        inventory.loots.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(inventory.loots, id: \.self) { item in
                    LootRow(item: item)
                        .environmentObject(inventory)
                }
                .onDelete{ index in deleteLoot(at: index)}
            }
            .sheet(isPresented: $showAddItemView, content: {
                AddOrEditItemView()
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

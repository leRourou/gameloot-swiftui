//
//  AddItemView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import SwiftUI

struct AddItemView: View {
    @State private var name: String = ""
    @State private var rarity: Rarity = .common
    @EnvironmentObject var inventory : Inventory
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section {
                TextField("Nom de l'objet", text: $name)
                Picker("Rareté", selection: $rarity) {
                    ForEach(Rarity.allCases, id: \.self) { rarity in
                        Text(String(describing: rarity).capitalized)
                    }
                }
                Button(action: {
                    inventory.addItem(item: $name.wrappedValue)
                    dismiss()
                }, label: {
                    Text("Ajouter")
                })
            }
        }
    }
}


#Preview {
    AddItemView()
}

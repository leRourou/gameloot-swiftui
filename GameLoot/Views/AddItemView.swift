//
//  AddItemView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import SwiftUI

struct AddItemView: View {
    @State private var lootItem: LootItem = LootItem.emptyLootItem
    @State private var isAttackItem: Bool = false
    @EnvironmentObject private var inventory: Inventory
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Nom de l'objet", text: $lootItem.name)
                Picker("Rareté", selection: $lootItem.rarity) {
                    ForEach(Rarity.allCases, id: \.self) { rarity in
                        HStack(alignment: .center, spacing: 3) {
                            Text(String(describing: rarity).capitalized)
                        }
                    }
                }
            }
            
            Section {
                Picker("Jeu", selection: $lootItem.game) {
                    ForEach(MockData.availableGames, id: \.self) { game in
                        Text(game.name)
                    }
                }
                
                Stepper("Combien : \(lootItem.quantity)", value: $lootItem.quantity, in: 0...100, step: 1)}
            
            StrengthToggle(attackStrength: lootItem.attackStrength)
            Section {
                Text("Type : " + $lootItem.type.wrappedValue.getEmoji())
                Picker("Type", selection: $lootItem.type) {
                    ForEach(ItemType.allCases, id: \.self) { tag in
                        Text(tag.getEmoji())
                    }
                }.pickerStyle(.palette)
                
            }
            
            Button(action: {
                inventory.addItem(item: lootItem)
                dismiss()
            }, label: {
                Text("Ajouter l'objet")
            })
        }
    }
}

struct StrengthToggle: View {
    @State var attackStrength: Int?
    var body: some View {
        Section {
            Toggle("Item d'attaque ?", isOn: Binding(
                get: { attackStrength != nil },
                set: { newValue in
                    if newValue {
                        attackStrength = 0
                    } else {
                        attackStrength = nil
                    }
                }
            ))
            
            Group {
                if attackStrength != nil {
                    Stepper("Force d'attaque : \(attackStrength!)", value: Binding(
                        get: { attackStrength ?? 0 },
                        set: { newValue in attackStrength = newValue }
                    ), in: 0...100, step: 1)
                }
            }
        }
    }
}

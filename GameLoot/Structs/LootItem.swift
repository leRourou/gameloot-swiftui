//
//  LootItem.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import Foundation
import SwiftUI

struct LootItem: Identifiable, Hashable {
    let id: UUID = UUID()
    var quantity: Int = 1
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int?
    var game: Game
    var image: Image?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static var emptyLootItem = LootItem(
        name: "",
        type: ItemType.unknown,
        rarity: Rarity.common,
        attackStrength: nil,
        game: Game.emptyGame,
        image: Image(systemName: "rectangle")
    )
}

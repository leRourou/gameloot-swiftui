//
//  LootItem.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import Foundation

struct LootItem {
    var quantity: Int = 1
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int?
    var game: Game
}

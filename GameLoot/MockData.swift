//
//  MoqData.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import Foundation

class MockData {
    static let availableGames = [
        Game(name: "Minecraft", genre: .rpg, coverName: "minecraft"),
        Game(name: "League of Legends", genre: .rpg, coverName: "league_of_legends"),
        Game(name: "Zelda : The Breath Of The Wild", genre: .mmorpg, coverName: "breath_of_the_wild"),
        Game(name: "Pokémon", genre: .fps, coverName: "pokémon"),
        Game(name: "The Witcher 3", genre: .looter, coverName: "the_witcher_3")
    ]

    static let lootItemsMock: [LootItem] = [
        LootItem(name: "Magic Wand", type: .magic, rarity: .common, attackStrength: 20, game: availableGames[0]),
        LootItem(name: "Fire Staff", type: .fire, rarity: .uncommon, attackStrength: 25, game: availableGames[0]),
        LootItem(name: "Ice Dagger", type: .ice, rarity: .rare, attackStrength: 30, game: availableGames[0]),
        LootItem(name: "Wind Bow", type: .wind, rarity: .epic, attackStrength: 35, game: availableGames[0]),
        LootItem(name: "Poison Ring", type: .poison, rarity: .legendary, attackStrength: 40, game: availableGames[0]),
        LootItem(name: "Thunder Shield", type: .thunder, rarity: .common, attackStrength: 22, game: availableGames[1]),
        LootItem(name: "Dagger of Legends", type: .dagger, rarity: .uncommon, attackStrength: 28, game: availableGames[1]),
        LootItem(name: "Bow of Shadows", type: .bow, rarity: .rare, attackStrength: 32, game: availableGames[1]),
        LootItem(name: "Ring of Power", type: .ring, rarity: .epic, attackStrength: 36, game: availableGames[1]),
        LootItem(name: "Unknown Artifact", type: .unknown, rarity: .unique, attackStrength: 42, game: Game.emptyGame),
    ]
}

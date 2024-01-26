//
//  LootRow.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/23/24.
//

import SwiftUI

struct LootRow: View {
    public var item: LootItem
    @EnvironmentObject private var inventory: Inventory

    var body: some View {
        NavigationLink {
            LootDetailView(item: item)
                .environmentObject(inventory)

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


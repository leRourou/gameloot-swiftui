//
//  LootView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import SwiftUI

struct LootDetailView: View {
    public var item: LootItem
    
    var body: some View {
        Rectangle()
            .fill(Color(item.rarity.getColor()))
            .frame(width: 150, height: 150)
            .cornerRadius(20)
            .shadow(color: Color(item.rarity.getColor()), radius: 40)
            .overlay(
                Text(item.type.getEmoji())
                    .font(.system(size: 80))
                    .foregroundColor(.white)
            )
            .padding(.bottom, 20)
        Text(item.name)
    }
}

#Preview {
    LootDetailView(item: MockData.lootItemsMock[0])
}


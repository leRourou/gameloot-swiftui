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
            .padding(.bottom, 50)
        Text(item.name)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .font(.system(size: 36))
            .foregroundStyle(Color(item.rarity.getColor()))
        if (item.rarity == Rarity.unique) {
            VStack() {
                Rectangle()
                    .fill(item.rarity.getColor())
                    .cornerRadius(20)
                    .frame(height: 50)
                    .padding(10)
                    .overlay(
                        Text("Item Unique 🏆")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
            }
        }
        Group {
            Text("try")
        }
    }
}

#Preview {
    LootDetailView(item: MockData.lootItemsMock[10])
}


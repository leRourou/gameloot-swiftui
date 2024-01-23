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
        LootDetailIcon(item: item)
        VStack(
        ) {
            List() {
                Section(
                    header: Text("INFORMATIONS")
                ) {
                    HStack {
                        if let cover = item.game.coverName {
                            Image(cover)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 58)
                                .clipShape(.rect(cornerRadius: 4))
                            
                        } else {
                            Image(systemName: "rectangle.slash")
                                .scaledToFit()
                                .frame(height: 58)
                                .padding(Edge.Set.horizontal, 8)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.gray]), startPoint: .top, endPoint: .bottom)
                                )
                                .clipShape(.rect(cornerRadius: 4))
                                .foregroundStyle(Color.black)
                                .opacity(0.4)
                            
                        }
                        
                        Text("Game: \(item.game.name)")
                    }
                    HStack {
                        Text("In-game: \(item.name)")
                    }
                    HStack {
                        Text("Puissance (ATQ): \(item.attackStrength!)")
                    }
                    HStack {
                        Text("Possédé(s): \(item.quantity)")
                    }
                    HStack {
                        Text("Rareté : \(item.rarity.getString())")
                    }
                }
            }
        }
    }
}

struct LootDetailIcon: View {
    public var item: LootItem
    @State var isAppeared: Bool = false
    @State var isIconClicked: Bool = false

    var body: some View {
        Rectangle()
            .fill(Color(item.rarity.getColor()))
            .frame(width: 150, height: 150)
            .cornerRadius(20)
            .overlay(
                Text(item.type.getEmoji())
                    .font(.system(size: 80))
                    .foregroundColor(.white)
            )
            .padding(.bottom, 50)
            .animation(.spring) {
                $0.rotation3DEffect(Angle(degrees: isAppeared ? 360 : 0), axis: (x: 1, y: 0.5, z: 0))
            }
            .animation(.bouncy(duration: 1).delay(0.2)) {
                $0.shadow(color: Color(item.rarity.getColor()), radius: isAppeared ? 100 : 0)
            }
            .onAppear {
                Task {
                    try await Task.sleep(nanoseconds:400_000_000)
                    isAppeared.toggle()
                }
            }
            .animation(.spring) {
                $0.scaleEffect(isIconClicked ? 1.5: 1.0)
            }
            .onTapGesture {
                isIconClicked.toggle()
            }
        
        Text(item.name)
            .fontWeight(.bold)
            .font(.system(size: 36))
            .foregroundStyle(Color(item.rarity.getColor()))
        if (item.rarity == Rarity.unique) {
            LootDetailUnique(
                isAppeared: isAppeared,
                item: item
            )
        }
    }
}

struct LootDetailUnique: View {
    var isAppeared: Bool
    var item: LootItem
    
    var body: some View {
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
                .animation(.spring) {
                    $0.rotation3DEffect(Angle(degrees: isAppeared ? 0 : 90), axis: (x: 1, y: 0, z: 0))
                        .scaleEffect(isAppeared ? 1 : 0.5)
                }
        }
    }
}

#Preview {
    LootDetailView(item: MockData.lootItemsMock[5])
}

//
//  ContentView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import SwiftUI

struct ContentView: View {
    var loot = ["Epée", "Bouclier", "Armure"]

    var body: some View {
        List(loot) { item in
            Text(item)
        }
    }
}
#Preview {
    ContentView()
}

//
//  Rarity.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import Foundation
import SwiftUI

enum Rarity: CaseIterable {
    case common;
    case uncommon;
    case rare;
    case epic;
    case legendary;
    case unique;
    
    func getColor()->Color {
        switch self {
        case .common : return Color.gray
        case .uncommon : return Color.green
        case .rare : return Color.blue
        case .epic : return Color.purple
        case .legendary : return Color.yellow
        case .unique : return Color.red
        }
    }
}

//
//  ItemType.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import Foundation

enum ItemType: CaseIterable {
    case magic;
    case fire;
    case ice;
    case wind;
    case poison;
    case thunder;
    case dagger;
    case shield;
    case bow;
    case ring;
    case unknown;
    
    func getEmoji()->String {
        switch self {
        case .magic : return "⭐️"
        case .fire : return "🔥"
        case .ice : return "❄️"
        case .wind : return "💨"
        case .poison : return "☠️"
        case .thunder : return "⚡️"
        case .dagger : return "🗡️"
        case .shield : return "🛡️"
        case .bow : return "🏹"
        case .ring : return "💍"
        case .unknown : return "🎲"
        }
    }
}

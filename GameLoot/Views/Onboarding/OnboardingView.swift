//
//  OnboardingView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/26/24.
//

import SwiftUI

struct OnboardingView: View {
    var setOnboardingDone: () -> Void
    @State private var currentPage: Int = 1
    
    var body: some View {
        onboardingPage()
    }
    
    @ViewBuilder
    private func onboardingPage() -> some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(
                title: "Gérer ses loots",
                symbol: "gym.bag.fill",
                color: Color.blue,
                description: "Ajoutez facilement vos trouvailles et vos achats à votre collection personnelle.",
                clickedOnNext: { currentPage += 1}
            ).tag(1)
            OnboardingPageView(
                title: "Votre Wishlist",
                symbol: "wand.and.stars",
                color: Color.red,
                description: "Gérez votre liste de souhaits pour garder une trace des articles que vous voulez acquérir.",
                clickedOnNext: { currentPage += 1 }
            ).tag(2)
            OnboardingPageView(
                title: "En un coup d'oeil",
                symbol: "iphone.rear.camera",
                color: Color.green,
                description: "Accèdez rapidement à vos fonctionnalités clés depuis l'écran d'accueil de l'appareil.",
                clickedOnNext: { setOnboardingDone() },
                isLast: true
            ).tag(3)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))

    }
}


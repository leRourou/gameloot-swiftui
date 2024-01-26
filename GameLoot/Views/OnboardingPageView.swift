//
//  OnboardingPageView.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/26/24.
//

import SwiftUI

struct OnboardingPageView: View {
    var title: String
    var symbol: String
    var color: Color
    var description: String
    var clickedOnNext: () -> Void
    var isLast = false
    
    var body: some View {
        VStack {
            Text(title)
                .padding()
                .fontWidth(Font.Width.expanded)
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)

            Image(systemName: symbol)
                .padding(40)
                .font(.system(size: 80))
                .background(color)
                .foregroundStyle(Color.white)
                .clipShape(Circle())
            
            Text(description)
                .padding(Edge.Set.horizontal, 50)
                .padding(Edge.Set.top, 30)
                .fontWidth(Font.Width.expanded)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                        
            Button(isLast ? "Commencer" : "Suivant") {
                clickedOnNext()
            }
            .padding(Edge.Set.vertical, 10)
            .padding(Edge.Set.horizontal, 20)
            .fontWeight(.heavy)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .foregroundStyle(Color.white)
            .padding(Edge.Set.vertical, 50)

        }
    }
}

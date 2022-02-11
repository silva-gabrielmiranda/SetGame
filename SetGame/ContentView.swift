//
//  ContentView.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var game: ViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("New game")
                    .padding()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        game.newGame()
                    }
                Spacer()
                if (game.numberOfShowingCards == game.cards.count){
                    Text("Deck is empty")
                        .padding()
                        .foregroundColor(.gray)
                } else {
                    Text("Deal 3 cards!")
                        .padding()
                        .foregroundColor(.blue)
                        .onTapGesture {
                            game.dealMoreCards()
                        }
                }
                
            }
            AspectVGrid(items: Array(game.cards[0..<game.numberOfShowingCards]), aspectRatio: DrawingConstants.cardsAspectRatio, content: { card in
                cardView(for: card)
            })
        }
    }
    
    @ViewBuilder
    private func cardView(for card: Model.Card) -> some View{
        CardView(card: card)
            .foregroundColor(game.chooseColor(card.color))
            .padding(DrawingConstants.paddingBetweenCards)
            .onTapGesture {
                game.chooseCard(card)
            }
    }
    
    private struct DrawingConstants{
        static let paddingBetweenCards: CGFloat = 1
        static let cardsAspectRatio: CGFloat = 2/3
    }
}

struct CardView: View{
    let card: Model.Card
    
    private var shapes: some View{
        VStack{
            ForEach(0..<card.numberOfShapes) { _ in
                switch (card.shape){
                case .diamond:
                    switch card.shading {
                        case .open: Diamond().stroke(lineWidth: DrawingConstants.lineWidth)
                        case .solid: Diamond()
                        case .stripped: Diamond().opacity(DrawingConstants.shapeOpacity)
                    }
                case .squiggle:
                    switch card.shading {
                        case .open: Squiggle().stroke(lineWidth: DrawingConstants.lineWidth)
                        case .solid: Squiggle()
                        case .stripped: Squiggle().opacity(DrawingConstants.shapeOpacity)
                    }
                case .oval:
                    switch card.shading {
                        case .open: Oval().stroke(lineWidth: DrawingConstants.lineWidth)
                        case .solid: Oval()
                        case .stripped: Oval().opacity(DrawingConstants.shapeOpacity)
                    }
                }
            }
        }
    }
    
    var body: some View{
        ZStack{
            let cardBackground = RoundedRectangle(cornerRadius: DrawingConstants.backgroundCornerRadius)
            switch card.status{
                case .notMatched: cardBackground.fill().foregroundColor(.red).opacity(DrawingConstants.backgrougOpacity)
                case .matched: cardBackground.fill().foregroundColor(.green).opacity(DrawingConstants.backgrougOpacity)
                case .selected: cardBackground.fill().foregroundColor(.blue).opacity(DrawingConstants.backgrougOpacity)
                case .idle: cardBackground.fill().foregroundColor(.gray).opacity(DrawingConstants.backgrougOpacity)
            }
            shapes
        }
    }
    
    private struct DrawingConstants{
        static let backgrougOpacity: Double = 0.4
        static let backgroundCornerRadius: CGFloat = 10
        static let shapeCornerRadius: CGFloat = 200
        static let shapeOpacity: Double = 0.5
        static let lineWidth: CGFloat = 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ViewModel()
        ContentView(game: game)
            .previewInterfaceOrientation(.portrait)
    }
}

//
//  ContentView.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var game: ViewModel
    
    @Namespace private var matchedNamespace
    
    var body: some View {
        VStack{
            AspectVGrid(items: Array(game.cards[0..<game.numberOfShowingCards]).filter({$0.status != .matched}), aspectRatio: DrawingConstants.cardsAspectRatio, content: { card in
                cardView(for: card)
                    .matchedGeometryEffect(id: card.id, in: matchedNamespace)
                    .onTapGesture {
                        withAnimation{
                                game.chooseCard(card)
                    
                        }
                    }
            })
            
            HStack{
                matchedDeck
                Spacer()
                newGameButton
                Spacer()
                deckBody
                    .onTapGesture {
                        for index in 0..<3 {
                            withAnimation(dealAnimation(delay: Double(index) / 10)){
                                game.dealMoreCards()
                            
                            }
                        }
                    }
            }
            .padding(.horizontal)
        }
    }
    
    private func dealAnimation(delay: Double) -> Animation {
        return Animation.easeOut.delay(delay);
    }
    
    var matchedDeck: some View{
        ZStack{
            Color.clear.frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
            ForEach(game.cards.filter({$0.status == .matched})){ card in
                Group{
                    cardView(for: card)
                        .matchedGeometryEffect(id: card.id, in: matchedNamespace)
                }
                .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
            }
            
        }
    }
    
    var deckBody: some View{
        ZStack{
            Color.clear.frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
            ForEach(Array(game.cards[game.numberOfShowingCards..<game.cards.count])){ card in
                Group{
                    cardView(for: card)
                        .matchedGeometryEffect(id: card.id, in: matchedNamespace)
                    RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                        .foregroundColor(.red)
                }
                .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
            }
            
        }
    }
    
    var newGameButton: some View{
        Text("New game")
            .padding()
            .foregroundColor(.blue)
            .font(Font.body.weight(.bold))
            .onTapGesture {
                withAnimation{
                    game.newGame()
                }
            }
    }
        
    @ViewBuilder
    private func cardView(for card: Model.Card) -> some View{
        CardView(card: card)
            .foregroundColor(game.chooseColor(card.color))
            .padding(DrawingConstants.paddingBetweenCards)
    }
    
    private struct DrawingConstants{
        static let paddingBetweenCards: CGFloat = 2
        static let cornerRadius: CGFloat = 10
        static let cardsAspectRatio: CGFloat = 2/3
        static let deckHeight: CGFloat = 90
        static let deckWidth = deckHeight * cardsAspectRatio
    }
}

struct CardView: View{
    let card: Model.Card
    
    var body: some View{
        ZStack{
            cardBackground
            shapes
        }
    }
    
    private var cardBackground: some View{
        ZStack{
            RoundedRectangle(cornerRadius: DrawingConstants.backgroundCornerRadius).fill().foregroundColor(.white)
            switch card.status{
                case .notMatched: RoundedRectangle(cornerRadius: DrawingConstants.backgroundCornerRadius).fill().foregroundColor(.red).opacity(DrawingConstants.backgrougOpacity)
                case .matched: RoundedRectangle(cornerRadius: DrawingConstants.backgroundCornerRadius).fill().foregroundColor(.green).opacity(DrawingConstants.backgrougOpacity)
                case .selected: RoundedRectangle(cornerRadius: DrawingConstants.backgroundCornerRadius).fill().foregroundColor(.blue).opacity(DrawingConstants.backgrougOpacity)
                case .idle: RoundedRectangle(cornerRadius: DrawingConstants.backgroundCornerRadius).fill().foregroundColor(.gray).opacity(DrawingConstants.backgrougOpacity)
            }
        }
    }
    
    private var shapes: some View{
        VStack{
            ForEach(0..<card.numberOfShapes, id: \.self) { _ in
                switch card.shape{
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
            .padding(DrawingConstants.shapesPadding)
    }
    
    private struct DrawingConstants{
        static let backgrougOpacity: Double = 0.4
        static let backgroundCornerRadius: CGFloat = 10
        static let shapeCornerRadius: CGFloat = 200
        static let shapeOpacity: Double = 0.5
        static let lineWidth: CGFloat = 2
        static let shapesPadding: CGFloat = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ViewModel()
        ContentView(game: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}

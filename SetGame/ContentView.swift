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
                Spacer()
                Text("Deal 3 cards!")
                    .padding()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        game.dealMoreCards()
                    }
            }
            AspectVGrid(items: game.cards, aspectRatio: DrawingConstants.cardsAspectRatio, content: { card in
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
                switch(card.shape){
                case "diamond":
                    if(card.shading == "open"){
                        Diamond().stroke(lineWidth: DrawingConstants.lineWidth)
                    } else if(card.shading == "solid"){
                        Diamond()
                    } else {
                        Diamond().opacity(DrawingConstants.shapeOpacity)
                    }
                case "squiggle":
                    if(card.shading == "open"){
                        Squiggle().stroke(lineWidth: DrawingConstants.lineWidth)
                    } else if(card.shading == "solid"){
                        Squiggle()
                    } else {
                        Squiggle().opacity(DrawingConstants.shapeOpacity)
                    }
                case "oval":
                    if(card.shading == "open"){
                        Oval().stroke(lineWidth: DrawingConstants.lineWidth)
                    } else if(card.shading == "solid"){
                        Oval()
                    } else {
                        Oval().opacity(DrawingConstants.shapeOpacity)
                    }
                default:
                    RoundedRectangle(cornerRadius: DrawingConstants.shapeCornerRadius)
                }
            }
        }
    }
    
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.backgroundCornerRadius)
                
                if(card.status == "notMatched"){
                    shape.fill().foregroundColor(.red).opacity(DrawingConstants.backgrougOpacity)
                } else if(card.status == "matched"){
                    shape.fill().foregroundColor(.green).opacity(DrawingConstants.backgrougOpacity)
                } else if(card.status == "selected"){
                    shape.fill().foregroundColor(.blue).opacity(DrawingConstants.backgrougOpacity)
                } else {
                    shape.fill().foregroundColor(.gray).opacity(DrawingConstants.backgrougOpacity)
                }
                shapes
            }
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

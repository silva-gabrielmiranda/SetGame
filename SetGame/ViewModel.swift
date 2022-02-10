//
//  ViewModel.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//

import SwiftUI

class ViewModel: ObservableObject{
    
    typealias Card = Model.Card
    
    @Published private var model = Model()
    
    func chooseColor(_ color: String) -> Color {
        
        var colorObject: Color = Color.orange
        
        switch(color){
        case "red":
            colorObject = Color.red
        case "blue":
            colorObject = Color.blue
        case "green":
            colorObject = Color.green
        default:
            colorObject = Color.orange
        }
        
        return colorObject
    }
    
    func chooseCard(_ card: Card){
        model.chooseCard(card)
    }
    
    func dealMoreCards(){
        model.dealMoreCards()
    }
    
    var cards: Array<Card>{
        var cards: Array<Card> = []
        let allCards = model.cards
        
        for index in 0..<model.numberOfShowingCards {
            cards.append(allCards[index])
        }
//        cards.append(model.cards.first!)
        
        return cards
    }
}

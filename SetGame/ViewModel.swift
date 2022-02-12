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
    
    func chooseColor(_ color: Card.color) -> Color {
        switch(color){
            case .red: return Color.red
            case .blue: return Color.blue
            case .green: return Color.green
        }
    }
    
    func chooseCard(_ card: Card){
        model.chooseCard(card)
    }
    
    func dealMoreCards(){
        model.dealMoreCards()
    }
    
    var numberOfShowingCards: Int{
        return model.numberOfShowingCards
    }
    
    var cards: Array<Card>{
        return model.cards
    }
    func newGame(){
        model.newGame()
    }
}

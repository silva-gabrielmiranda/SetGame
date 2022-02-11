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

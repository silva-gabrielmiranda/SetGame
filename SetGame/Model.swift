//
//  Model.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//

import Foundation
import SwiftUI

enum shape{
    case diamond
    case squiggle
    case open
}

struct Model {
    var cards: Array<Card> = []
    static let numberOfShapesOptions = [1, 2, 3]
    static let shapeOptions = ["diamond", "squiggle", "oval"]
    static let shadingOptions = [ "solid", "stripped", "open"]
    static let colorOptions = ["green", "blue", "red"]
    var selectedCards: Array<Card>{
        
        var selectedCardsList: Array<Card> = []
        
        for cardIndex in cards.indices{
            if(cards[cardIndex].status == "selected"){
                selectedCardsList.append(cards[cardIndex])
            }
        }
        
        return selectedCardsList
    }
    
    var numberOfShowingCards: Int = 12
    
    init(){
        newGame()
    }
    
    mutating func newGame(){
        cards = []
        var id: Int = 0
        for numberOfShapesIndex in Model.numberOfShapesOptions.indices {
            for shapeIndex in Model.shapeOptions.indices {
                for shadingIndex in Model.shapeOptions.indices {
                    for colorIndex in Model.colorOptions.indices {
                        cards.append(
                            Card(
                                numberOfShapes: Model.numberOfShapesOptions[numberOfShapesIndex],
                                shape: Model.shapeOptions[shapeIndex],
                                shading: Model.shadingOptions[shadingIndex],
                                color: Model.colorOptions[colorIndex],
                                id: id
                            )
                        )
                        id += 1
                    }
                }
            }
        }
        cards = cards.shuffled()
    }
    
    mutating func chooseCard(_ card: Card){
        print("Choosed Card. Selected cards = \(selectedCards.count)")
        var newCard = card
        
        if((card.status == "idle" || card.status == "notMatched") && selectedCards.count < 3){
            newCard.status = "selected"
        }
        if(card.status == "selected"){
            newCard.status = "idle"
        }
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            cards[chosenIndex] = newCard
        }

        if(selectedCards.count >= 3){
            validateMatches()
        }
        
        //Resetar cards, matched = deleta, notMatched
    }
    
    mutating func dealMoreCards(){
        if(numberOfShowingCards < cards.count - 3){
            numberOfShowingCards += 3
        } else {
            numberOfShowingCards = cards.count
        }
    }
    
    func validateShape() -> Bool{
        
        if(selectedCards[0].shape == selectedCards[1].shape && selectedCards[1].shape == selectedCards[2].shape){
            return true
        }
        
        if(selectedCards[0].shape != selectedCards[1].shape && selectedCards[1].shape != selectedCards[2].shape && selectedCards[0].shape != selectedCards[2].shape){
            return true
        }
        
        return false
    }

    func validateShading() -> Bool{
        
        if(selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading){
            return true
        }
        
        if(selectedCards[0].shading != selectedCards[1].shading && selectedCards[1].shading != selectedCards[2].shading && selectedCards[0].shading != selectedCards[2].shading){
            return true
        }
        
        return false
    }
    
    func validateNumberOfShapes() -> Bool{
        
        if(selectedCards[0].numberOfShapes == selectedCards[1].numberOfShapes && selectedCards[1].numberOfShapes == selectedCards[2].numberOfShapes){
            return true
        }
        
        if(selectedCards[0].numberOfShapes != selectedCards[1].numberOfShapes && selectedCards[1].numberOfShapes != selectedCards[2].numberOfShapes && selectedCards[0].numberOfShapes != selectedCards[2].numberOfShapes){
            return true
        }
        
        return false
    }
    
    func validateColor() -> Bool{
        
        if(selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color){
            return true
        }
        
        if(selectedCards[0].color != selectedCards[1].color && selectedCards[1].color != selectedCards[2].color && selectedCards[0].color != selectedCards[2].color){
            return true
        }
        
        return false
    }
    
    mutating func validateMatches(){
        
        if(validateColor() && validateShape() && validateShading() && validateNumberOfShapes()){
            print("Valid match")
            
            for cardIndex in cards.indices{
                if(cards[cardIndex].status == "selected"){
                    cards[cardIndex].status = "matched"
                }
            }
        } else {
            for cardIndex in cards.indices{
                if(cards[cardIndex].status == "selected"){
                    cards[cardIndex].status = "notMatched"
                }
            }
        }
        
    }
    
    struct Card: Identifiable {
        let numberOfShapes: Int
        let shape: String
        let shading: String
        let color: String
        var status: String = "idle" //notMatched, matched, selected, idle
        let id: Int
    }
}

//
//  Model.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//

import Foundation
import SwiftUI

struct Model {
    var cards: Array<Card> = []
    static let numberOfShapesOptions = [1, 2, 3]
    static let shapeOptions = [Card.shape.diamond, Card.shape.oval, Card.shape.squiggle]
    static let shadingOptions = [ Card.shading.solid, Card.shading.stripped, Card.shading.open]
    static let colorOptions = [Card.color.green, Card.color.red, Card.color.blue]
    var selectedCards: Array<Card>{
        return cards.filter({$0.status == .selected})
    }
    var numberOfShowingCards: Int = 12
    
    init(){
        newGame()
    }
    
    mutating func newGame(){
        cards = []
        numberOfShowingCards = 12
        var id: Int = 1
        for numberOfShapesIndex in Model.numberOfShapesOptions.indices {
            for shapeIndex in Model.shapeOptions.indices {
                for shadingIndex in Model.shadingOptions.indices {
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
//        cards.shuffle()
    }
    
    mutating func clearMatchesAndNoMatches(){
        for index in cards.indices.reversed(){
            if(cards[index].status == .notMatched){
                cards[index].status = .idle
            }
        }
    }
    
    mutating func chooseCard(_ card: Card){
        print("Card selected \(card.id)")
        
        clearMatchesAndNoMatches()
        
        var newCard = card
        
        if((card.status == .idle || card.status == .notMatched) && selectedCards.count < 3){
            newCard.status = .selected
        }
        if(card.status == .selected){
            newCard.status = .idle
        }
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            cards[chosenIndex] = newCard
        }

        if(selectedCards.count >= 3){
            validateMatches()
        }
    }
    
    mutating func dealMoreCards(){
        clearMatchesAndNoMatches()
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
                if(cards[cardIndex].status == .selected){
                    cards[cardIndex].status = .matched
                }
            }
        } else {
            for cardIndex in cards.indices{
                if(cards[cardIndex].status == .selected){
                    cards[cardIndex].status = .notMatched
                }
            }
        }
        
    }
    
    struct Card: Identifiable {
        let numberOfShapes: Int
        let shape: shape
        let shading: shading
        let color: color
        var status: status = .idle
        let id: Int
    
        enum shape{
            case diamond
            case squiggle
            case oval
        }
        enum shading {
            case solid
            case stripped
            case open
        }

        enum status{
            case notMatched
            case idle
            case matched
            case selected
        }
        enum color{
            case red
            case green
            case blue
        }
    }
}

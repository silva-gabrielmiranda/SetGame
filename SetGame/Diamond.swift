//
//  Diamond.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//


import SwiftUI

struct Diamond: Shape{
    

    
    func path(in rect: CGRect) -> Path {
        
        let distance = rect.maxX * 0.2
        
        let center = CGPoint(
            x: rect.midX,
            y: rect.midY
        )
        
        let top = CGPoint(
            x: center.x,
            y: center.y - distance
        )
        let right = CGPoint(
            x: center.x + distance,
            y: center.y
        )
        let bottom = CGPoint(
            x: center.x,
            y: center.y + distance
        )
        let left = CGPoint(
            x: center.x - distance,
            y: center.y
        )
        
        
        var p = Path()
        
        p.move(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        p.addLine(to: top)
        
        
        return p
    }
    
    
}

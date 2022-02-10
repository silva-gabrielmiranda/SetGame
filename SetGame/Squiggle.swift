//
//  Diamond.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//


import SwiftUI

struct Squiggle: Shape{
    
    let firstAngle = Angle(degrees: 0-90)
    let secondAngle = Angle(degrees: 90-90)
    let thirdAngle = Angle(degrees: 180-90)
    let fourthAngle = Angle(degrees: 270-90)
    
    func path(in rect: CGRect) -> Path {

        // MARK: LEFT
        let topLeft = CGPoint(
            x: rect.midX / 2,
            y: rect.midY - (rect.maxX * 0.2) / 2
        )
        let bottomLeft = CGPoint(
            x: rect.midX / 2,
            y: rect.midY + (rect.maxX * 0.2) / 2
        )
        
        // MARK: Right
        let topRight = CGPoint(
            x: rect.midX * 1.5,
            y: rect.midY - (rect.maxX * 0.2) / 2
        )
        let bottomRight = CGPoint(
            x: rect.midX * 1.5,
            y: rect.midY + (rect.maxX * 0.2) / 2
        )
        
        // MARK: Mid
        let topMid = CGPoint(
            x: rect.midX,
            y: rect.midY - (rect.maxX * 0.2) / 2
        )
        let bottomMid = CGPoint(
            x: rect.midX,
            y: rect.midY + (rect.maxX * 0.2) / 2
        )
        
        
        // MARK: Offsets
        
        let topMidRight = CGPoint(
            x: rect.midX - ((rect.midX - rect.midX * 1.5) / 2),
            y: (rect.midY - (rect.maxX * 0.2) / 2) - (((rect.midY + (rect.maxX * 0.2) / 2) - (rect.midY - (rect.maxX * 0.2) / 2)) / 2)
        )
        let topMidLeft = CGPoint(
            x: rect.midX + ((rect.midX - rect.midX * 1.5) / 2),
            y: (rect.midY - (rect.maxX * 0.2) / 2) + (((rect.midY + (rect.maxX * 0.2) / 2) - (rect.midY - (rect.maxX * 0.2) / 2)) / 2)
        )
        let bottomMidRight = CGPoint(
            x: rect.midX - ((rect.midX - rect.midX * 1.5) / 2),
            y: (rect.midY + (rect.maxX * 0.2) / 2) + (rect.midY - (rect.midY + (rect.maxX * 0.2) / 2))
        )
        let bottomMidLeft = CGPoint(
            x: rect.midX + ((rect.midX - rect.midX * 1.5) / 2),
            y: (rect.midY + (rect.maxX * 0.2) / 2) - (rect.midY - (rect.midY + (rect.maxX * 0.2) / 2))
        )
        
        var p = Path()
        
        p.move(to: topLeft)
        p.addQuadCurve(to: topMid, control: topMidLeft)
        p.addQuadCurve(to: topRight, control: topMidRight)
        p.addLine(to: bottomRight)
        p.addQuadCurve(to: bottomMid, control: bottomMidRight)
        p.addQuadCurve(to: bottomLeft, control: bottomMidLeft)
        p.addLine(to: topLeft)
        
        
        
        return p
    }
}

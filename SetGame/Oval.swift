//
//  Diamond.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//


import SwiftUI

struct Oval: Shape{
    
    func path(in rect: CGRect) -> Path {
        //let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = CGFloat((rect.maxX * 0.2) / 2)

        // MARK: - LEFT
        let topLeft = CGPoint(
            x: rect.midX / 2,
            y: rect.midY - (rect.maxX * 0.2) / 2
        )
        let bottomLeft = CGPoint(
            x: rect.midX / 2,
            y: rect.midY + (rect.maxX * 0.2) / 2
        )
        
        // MARK: - Right
        let topRight = CGPoint(
            x: rect.midX * 1.5,
            y: rect.midY - (rect.maxX * 0.2) / 2
        )
        let bottomRight = CGPoint(
            x: rect.midX * 1.5,
            y: rect.midY + (rect.maxX * 0.2) / 2
        )
        
        
        // MARK: - Center
        let centerLeft = CGPoint(
            x: rect.midX / 2,
            y: rect.midY
        )
        let centerRight = CGPoint(
            x: rect.midX * 1.5,
            y: rect.midY
        )
        
        var p = Path()
        
        p.move(to: topLeft)
        p.addLine(to: topRight)
        p.move(to: bottomRight)
        p.addLine(to: bottomLeft)
        p.addArc(center: centerLeft, radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 270), clockwise: false)
        p.addArc(center: centerRight, radius: radius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 90), clockwise: false)
        
        return p
    }
    
    
}

//
//  SetGameApp.swift
//  SetGame
//
//  Created by Gabriel Miranda on 26/12/21.
//

import SwiftUI

@main
struct SetGameApp: App {
    var game = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}

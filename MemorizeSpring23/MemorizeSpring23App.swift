//
//  MemorizeSpring23App.swift
//  MemorizeSpring23
//
//  Created by Filippo Pellolio on 10/30/23.
//

import SwiftUI

@main
struct MemorizeSpring23App: App {
    @StateObject var game = EmojiMemoryGame()
  
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}

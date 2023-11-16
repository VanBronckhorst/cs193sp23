//
//  EmojiMemoryGame.swift
//  MemorizeSpring23
//
//  Created by Filippo Pellolio on 11/11/23.
//

import Foundation
import SwiftUI

class EmojiMemoryGame : ObservableObject {
  @Published private var game : MemoryGame<String>
  @Published private var theme : Theme
  
  init() {
    let theme = EmojiMemoryGame.pickRandomTheme()
    self.theme = theme
    game = EmojiMemoryGame.createNewGame(theme: theme)
  }
  
  var cards: [MemoryGame<String>.Card] {
    game.cards
  }
  
  var style : CardStyle {
    EmojiMemoryGame.colorsMap[theme.cardColor] ?? CardStyle.color(.gray)
  }
  
  var themeName : String {
    theme.name
  }
  
  var score : Int {
    game.score
  }
  
  func choose(_ card: MemoryGame<String>.Card) {
    game.choose(card, at: Date())
  }
  
  func shuffle() {
    game.shuffle()
  }
  
  func newGame() {
    theme = EmojiMemoryGame.pickRandomTheme()
    game = EmojiMemoryGame.createNewGame(theme: theme)
  }
  
  private static func pickRandomTheme() -> Theme {
    Theme.allThemes.randomElement() ?? Theme.animals
  }
  
  private static func createNewGame(theme: Theme) -> MemoryGame<String> {
    var pairs = theme.pairsCount ?? Int.random(in: 2...theme.emojis.count)
    pairs = min(max(2, pairs), theme.emojis.count)
    // This ensures each new game has a different set of emojis if the count less than the full set.
    let shuffledEmojis = theme.emojis.shuffled()
    return MemoryGame<String>(numberOfPairs: pairs) { shuffledEmojis[$0] }
  }
  
  private static let colorsMap : [String:CardStyle] = [
    "green" : .color(.green),
    "red" : .color(.red),
    "orange" : .color(.orange),
    "blue" : .color(.blue),
    "brown" : .color(.brown),
    "gradient": .linearGradient(LinearGradient(colors: [.blue, .red ,.green], startPoint: .top, endPoint: .bottom)),
    "circle": .circle(RadialGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startRadius: 10, endRadius: 30))
  ]
}

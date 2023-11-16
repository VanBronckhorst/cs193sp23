//
//  MemoryGame.swift
//  MemorizeSpring23
//
//  Created by Filippo Pellolio on 11/11/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable, CardContent: Hashable {
  private(set) var cards : [Card]
  private(set) var score : Int = 0
  private var seenCards : Set<String> = Set<String>()
  private var faceUpTime : Date?
  
  init(numberOfPairs: Int, cardFactory: (Int) -> CardContent) {
    // Create a UUID that is unique to the game instance, so cards from different games cannot be equal
    let uuid = UUID()
    self.cards = (0..<numberOfPairs).flatMap { index in
      let content = cardFactory(index)
      return [
        Card(id: "\(index)a - \(uuid)", content: content),
        Card(id: "\(index)b - \(uuid)", content: content)
      ]
    }.shuffled()
  }
  
  private var onlyFaceUpCardIndex : Int? {
    get {
      cards.indices.filter {cards[$0].isFaceUp}.only()
    }
    
    set {
      cards.indices.forEach {
        cards[$0].isFaceUp = $0 == newValue
      }
    }
  }
  
  mutating func choose(_ card: MemoryGame<CardContent>.Card, at time: Date) {
    if let chosenIndex = cards.firstIndex(of: card) {
      if (cards[chosenIndex].isMatched || cards[chosenIndex].isFaceUp) {
        return
      }
      // Anything under here will cause a score change.
      
      if let potentialMatchIndex = onlyFaceUpCardIndex, let faceUpTime {
        let secondsPassed = time.timeIntervalSince(faceUpTime)
        let multiplier = Int(max(1, 100 - secondsPassed * 10))
        
        if (cards[potentialMatchIndex].content == cards[chosenIndex].content) {
          // Match!
          cards[potentialMatchIndex].isMatched = true
          cards[chosenIndex].isMatched = true
          score += 2 * multiplier
        } else {
          // Mismatch!
          if (seenCards.contains(cards[chosenIndex].id)) {
            score -= 1 * multiplier
          } else {
            seenCards.insert(cards[chosenIndex].id)
          }
          
          if (seenCards.contains(cards[potentialMatchIndex].id)) {
            score -= 1 * multiplier
          } else {
            seenCards.insert(cards[potentialMatchIndex].id)
          }
        }
      } else {
        onlyFaceUpCardIndex = chosenIndex
        faceUpTime = time
      }
      cards[chosenIndex].isFaceUp = true
    }
  }
  
  mutating func shuffle() {
    cards.shuffle()
  }
  
  struct Card : Equatable, Identifiable, Hashable {
    let id : String
    let content : CardContent
    var isFaceUp : Bool = false
    var isMatched : Bool = false
  }
}

extension Array {
  func only() -> Element? {
    count == 1 ? first : nil
  }
}

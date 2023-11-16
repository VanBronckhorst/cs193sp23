//
//  CardView.swift
//  MemorizeSpring23
//
//  Created by Filippo Pellolio on 11/11/23.
//

import Foundation
import SwiftUI

struct CardView: View {
  let card : MemoryGame<String>.Card
  let style : CardStyle
  
  var body: some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: 12)
      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2)
        Text(card.content)
          .font(.system(size: 200))
          .minimumScaleFactor(0.01)
          .aspectRatio(1, contentMode: .fit)
      }.opacity(card.isFaceUp ? 1 : 0)
      switch (style) {
      case .color(let col): base.fill(col).opacity(card.isFaceUp ? 0 : 1)
      case .linearGradient(let g): base.fill(g).opacity(card.isFaceUp ? 0 : 1)
      case .circle(let g): base.fill(g).opacity(card.isFaceUp ? 0 : 1)
      }
      
    }.opacity(!card.isMatched || card.isFaceUp ? 1 : 0)
  }
}

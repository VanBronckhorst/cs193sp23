//
//  ContentView.swift
//  MemorizeSpring23
//
//  Created by Filippo Pellolio on 10/30/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game : EmojiMemoryGame
    
    var body: some View {
      VStack {
        HStack {
          Text(game.themeName).font(.title2).bold()
          Spacer()
          Text("Score: \(game.score)")
        }
        ScrollView {
          cards
            .animation(.default, value: game.cards)
        }
        Spacer()
        Button("New Game") {game.newGame()}
      }.padding()
    }

    var cards : some View {
      LazyVGrid(columns:[
          GridItem(
            .adaptive(minimum: widthThatBestFits(game.cards.count)))
        ], spacing: 5) {
          ForEach(game.cards, id: \.self) { card in
            CardView(card: card, style: game.style)
            .aspectRatio(2/3 , contentMode: .fit)
            .onTapGesture {
              game.choose(card)
            }
        }
      }
    }

  func widthThatBestFits(_ cardsCount: Int) -> CGFloat {
    let minWidth : CGFloat = 50

    if (cardsCount < 5) {
      return minWidth * CGFloat(3)
    }

    if (cardsCount < 9) {
      return minWidth * CGFloat(2)
    }

    return minWidth
  }
}



struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
      EmojiMemoryGameView(game:EmojiMemoryGame())
    }
}

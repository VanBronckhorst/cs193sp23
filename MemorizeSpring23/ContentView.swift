//
//  ContentView.swift
//  MemorizeSpring23
//
//  Created by Filippo Pellolio on 10/30/23.
//

import SwiftUI

struct Theme {
  let name : String
  let emojis : [String]
  let symbol : Image
  let cardColor : Color
}

let animalEmojis = ["🦁", "🐸", "🦊", "🐼", "🐢", "🦉", "🦒", "🐳", "🦔", "🐍", "🦖", "🦩", "🐘", "🦝", "🐪"]
let animalTheme = Theme(name: "Animals", emojis: animalEmojis, symbol: Image(systemName: "pawprint"), cardColor: .green)

let travelEmojis = ["✈️", "🌍", "🗼", "🏝", "🚂", "🌅", "🗽", "🏜", "🚠", "🛶", "🗺", "⛩", "🌉", "🚗"]
let travelTheme = Theme(name: "Travel", emojis: travelEmojis, symbol: Image(systemName: "car"), cardColor: .blue)

let foodEmojis = ["🍉", "🍕", "🍣", "s🍦", "🥥", "🍍", "🍔", "🍫", "🥐", "🍓", "🍱", "🍺", "🍪"]
let foodTheme = Theme(name: "Food", emojis: foodEmojis, symbol: Image(systemName: "fork.knife"), cardColor: .brown)

struct ContentView: View {
    let availableThemes = [animalTheme, foodTheme, travelTheme]

    @State var selectedEmojis = animalEmojis.flatMap{[$0, $0]}.shuffled()
    @State var cardColor = animalTheme.cardColor

    var body: some View {
      VStack {
        Text("Memorize!").font(.largeTitle)
        ScrollView {
          cards
        }
        Spacer()
        themeButtons
      }.padding()
    }

    var cards : some View {
      LazyVGrid(columns:
                  [GridItem(.adaptive(minimum: widthThatBestFits(selectedEmojis.count)))]) {
        ForEach(0..<selectedEmojis.count, id: \.self) { index in
          CardView(icon: selectedEmojis[index]).aspectRatio(2/3 , contentMode: .fit)
        }
      }.foregroundColor(cardColor)
    }

    var themeButtons : some View {
      HStack (alignment: .bottom, spacing: 40){
        ForEach(availableThemes, id:\.name) { theme in
          Button(action: {
            selectedEmojis =
              theme
                .emojis[0...Int.random(in: 1..<theme.emojis.count)]
                .flatMap{[$0, $0]}.shuffled()
            cardColor = theme.cardColor
          }) {
            VStack(alignment: .center) {
              theme.symbol
              Text(theme.name).font(.caption)
            }
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

struct CardView: View {
  @State var isFaceUp : Bool = false
  let icon : String

  var body: some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: 12)
      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2)
        Text(icon).font(.largeTitle)
      }.opacity(isFaceUp ? 1 : 0)
      base.fill().opacity(isFaceUp ? 0 : 1)
    }
    .onTapGesture {
      isFaceUp.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

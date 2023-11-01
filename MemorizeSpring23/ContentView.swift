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
}

let animalEmojis = ["🦁", "🐸", "🦊", "🐼", "🐢", "🦉", "🦒", "🐳", "🦔", "🐍", "🦖", "🦩", "🐘", "🦝", "🐪"]
let animalTheme = Theme(name: "Animals", emojis: animalEmojis, symbol: Image(systemName: "pawprint"))

let travelEmojis = ["✈️", "🌍", "🗼", "🏝", "🚂", "🌅", "🗽", "🏜", "🚠", "🛶", "🗺", "⛩", "🌉", "🚗"]
let travelTheme = Theme(name: "Travel", emojis: travelEmojis, symbol: Image(systemName: "car"))

let foodEmojis = ["🍉", "🍕", "🍣", "🍦", "🥥", "🍍", "🍔", "🍫", "🥐", "🍓", "🍱", "🍺", "🍪"]
let foodTheme = Theme(name: "Food", emojis: foodEmojis, symbol: Image(systemName: "fork.knife"))

struct ContentView: View {
    let availableThemes = [animalTheme, foodTheme, travelTheme]

    @State var selectedEmojis = animalEmojis.flatMap{[$0, $0]}.shuffled()

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
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
      ForEach(0..<selectedEmojis.count, id: \.self) { index in
        CardView(icon: selectedEmojis[index]).aspectRatio(2/3 , contentMode: .fit)
      }
    }.foregroundColor(.blue)
  }

  var themeButtons : some View {
    HStack{
      ForEach(availableThemes, id:\.name) { theme in
        Button(action: {
          selectedEmojis = theme.emojis.flatMap{[$0, $0]}.shuffled()
        }) {
          VStack {
            theme.symbol
            Text(theme.name).font(.caption)
          }
        }
      }
    }
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

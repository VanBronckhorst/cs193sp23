//
//  Theme.swift
//  MemorizeSpring23
//
//  Created by Filippo Pellolio on 11/11/23.
//

import Foundation


struct Theme {
  let name : String
  let emojis : [String]
  let cardColor : String
  let pairsCount: Int?
  
  private static let animalEmojis = ["🦁", "🐸", "🦊", "🐼", "🐢", "🦉", "🦒", "🐳", "🦔", "🐍", "🦖", "🦩", "🐘", "🦝", "🐪"]
  static let animals = Theme(name: "Animals", emojis: animalEmojis, cardColor: "red", pairsCount: nil)

  private static let travelEmojis = ["✈️", "🌍", "🗼", "🏝", "🚂", "🌅", "🗽", "🏜", "🚠", "🛶", "🗺", "⛩", "🌉", "🚗"]
  static let travel = Theme(name: "Travel", emojis: travelEmojis, cardColor: "blue", pairsCount: 8)

  private static let foodEmojis = ["🍉", "🍕", "🍣", "🍦", "🥥", "🍍", "🍔", "🍫", "🥐", "🍓", "🍱", "🍺", "🍪"]
  static let foods = Theme(name: "Food", emojis: foodEmojis, cardColor: "gradient", pairsCount: 12)
  
  private static let sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥏", "🎳", "🏓", "🏸", "🥊", "🚴‍♂️", "🏊‍♀️", "🧗‍♂️"]
  static let sports = Theme(name: "Sports", emojis: sportsEmojis, cardColor: "orange", pairsCount: nil)

  private static let natureEmojis = ["🌸", "🌳", "🌵", "🌷", "🌺", "🍁", "🍄", "🌴", "🌲", "🌻", "🍂", "🍃", "🌿", "🌾", "🌊"]
  static let nature = Theme(name: "Nature", emojis: natureEmojis, cardColor: "green", pairsCount: nil)

  private static let technologyEmojis = ["💻", "📱", "🖥", "🕹", "📷", "🎥", "🔊", "🎧", "⌚️", "🖨", "📀", "🔋", "🛰", "🎮", "📡"]
  static let technology = Theme(name: "Technology", emojis: technologyEmojis, cardColor: "circle", pairsCount: 7)
  
  static let allThemes = [animals, travel, foods, sports, nature, technology]
}

//
//  SimpleConfig.swift
//  WidgetDayExtension
//
//  Created by Mahdia Amriou on 22/11/2023.
//

import Foundation
import SwiftUI

struct SimpleConfig {
    let backgroundColor: Color
    let quote: String
    let author: String

    static func determineConfig(from date: Date) -> SimpleConfig {
        let dayInt = Calendar.current.component(.weekday, from: date)

        switch dayInt {
        case 1:
            return SimpleConfig(
                backgroundColor: .orange,
                quote: "Happiness is a thing to be practiced, like the violin.",
                author: "John Lubbock"
            )
        case 2:
            return SimpleConfig(
                backgroundColor: .pink,
                quote: "Curiosity is one of the great secrets of happiness.",
                author: "Bryant H. McGill"
            )
        case 3:
            return SimpleConfig(
                backgroundColor: .purple,
                quote: "Don't let the fear of striking out hold you back.",
                author: "Babe Ruth"
            )
        case 4:
            return SimpleConfig(
                backgroundColor: .blue,
                quote: "The crown of life is neither happiness nor annihilation it is understanding.",
                author: "Winifred Holtby"
            )
        case 5:
            return SimpleConfig(
                backgroundColor: .mint,
                quote: "Happiness seems made to be shared.",
                author: "Pierre Corneille"
            )
        case 6:
            return SimpleConfig(
                backgroundColor: .green,
                quote: "Belief creates the actual fact.",
                author: "William James"
            )
        case 7:
            return SimpleConfig(
                backgroundColor: .teal,
                quote: "It is always the simple that produces the marvelous.",
                author: "Amelia Barr"
            )
        default:
            return SimpleConfig(
                backgroundColor: .gray,
                quote: "It not supposed to happen.",
                author: "Unknown"
            )
        }
    }
}

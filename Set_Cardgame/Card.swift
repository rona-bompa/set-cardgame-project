//
//  Card.swift
//  Set_Cardgame
//
//  Created by Rona Bompa on 24.02.2022.
//

import Foundation
import UIKit

struct Card: Equatable {
    let shapes: Shape
    let color: Color
    let filling: Filling
    let numberOfShapes: Int

    enum Shape: String, CustomStringConvertible {
        case triangle = "▲"
        case circle = "●"
        case square = "■"

        static var all = [Shape.triangle,.circle,.square]

        var description: String { return rawValue }
    }

    enum Color: String, CustomStringConvertible {
        case red = "red"
        case purple = "purple"
        case green = "green"

        static var all = [Color.red,.purple,.green]

        var description: String { return rawValue }

    }

    enum Filling: String, CustomStringConvertible {
        case empty = "empty"
        case stripped = "stripped"
        case full = "full"

        static var all = [Filling.empty,.stripped,.full]

        var description: String { return rawValue }
    }

}

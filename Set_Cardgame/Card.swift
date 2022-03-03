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

    enum Color: String {
        case red = "red"
        case purple = "purple"
        case green = "green"

        static var all = [Color.red,.purple,.green]

        func colorUI() -> UIColor {
            switch self {
            case .red:
                return UIColor.red
            case .purple:
                return UIColor.purple
            case .green:
                return UIColor.green
            }
        }
    }

    enum Filling: String {
        case empty = "empty"
        case stripped = "stripped"
        case full = "full"

        static var all = [Filling.empty,.stripped,.full]

        func strokeWidth() -> Float {
            switch self {
            case .empty:
                return 5.0
            case .stripped:
                return 0.0
            case .full:
                return 0.0
            }
        }

        func alphaComponent() -> Double {
            switch self {
            case .empty:
                return 0.0
            case .stripped:
                return 0.20
            case .full:
                return 1.0
            }
        }
    }

}

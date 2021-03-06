//
//  Reps.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 24/07/2021.
//

import SwiftUI
import Shared

public enum Reps {
    case one
    case three
    case five

    public var indicator: String {
        switch self {
        case .one:
            return "x1"
        case .three:
            return "x3"
        case .five:
            return "x5"
        }
    }

    public var color: Color {
        switch self {
        case .one:
            return .accentRed
        case .three:
            return .accentOrange
        case .five:
            return .accentGreen
        }
    }

    public var colorLight: Color {
        switch self {
        case .one:
            return .accentRedLight
        case .three:
            return .accentOrangeLight
        case .five:
            return .accentGreenLight
        }
    }
}

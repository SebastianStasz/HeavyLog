//
//  Reps.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 24/07/2021.
//

import SwiftUI

enum Reps {
    case one
    case three
    case five

    var indicator: String {
        switch self {
        case .one:
            return "x1"
        case .three:
            return "x3"
        case .five:
            return "x5"
        }
    }

    var color: Color {
        switch self {
        case .one:
            return AppColor.accentRed.color
        case .three:
            return AppColor.accentOrange.color
        case .five:
            return AppColor.accentGreen.color
        }
    }

    var colorLight: Color {
        switch self {
        case .one:
            return AppColor.accentRedLight.color
        case .three:
            return AppColor.accentOrangeLight.color
        case .five:
            return AppColor.accentGreenLight.color
        }
    }
}
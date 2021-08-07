//
//  BaseButtonStyle.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 26/07/2021.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
    }
}
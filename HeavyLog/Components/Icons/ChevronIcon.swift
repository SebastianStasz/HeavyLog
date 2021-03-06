//
//  ChevronIcon.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 25/09/2021.
//

import SwiftUI

struct ChevronIcon: View {
    var body: some View {
        Image(systemName: "chevron.forward")
            .font(.callout.weight(.light))
            .foregroundColor(.grayMedium)
    }
}


// MARK: - Preview

struct Chevron_Previews: PreviewProvider {
    static var previews: some View {
        ChevronIcon()
            .previewSizeThatFits(backgroundColor: .white)
    }
}

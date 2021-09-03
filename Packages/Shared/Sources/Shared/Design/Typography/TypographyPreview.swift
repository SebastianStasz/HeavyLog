//
//  TypographyPreview.swift
//  Shared
//
//  Created by Sebastian Staszczyk on 24/07/2021.
//

import SwiftUI

struct TypographyPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .spacingHuge) {

            Group {
                Text("Headline big Bold")
                    .textHeadlineBigBold

                Text("Headline big")
                    .textHeadlineBig

                Text("Headline small")
                    .textHeadlineSmall
            }
            .fontGroup("Headlines")

            Group {
                Text("Body bold")
                    .textBodyBold

                Text("Body medium")
                    .textBodyMedium

                Text("Body normal")
                    .textBodyNormal
            }
            .fontGroup("Body")

            Group {
                Text("Footnote main")
                    .textFootnoteMain
            }
            .fontGroup("Other")
        }
    }
}


// MARK: - Preview

struct TypographyPreview_Previews: PreviewProvider {
    static var previews: some View {
        TypographyPreview()
    }
}

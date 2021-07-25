//
//  ToastView.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 25/07/2021.
//

import SwiftUI

struct Toast1View: View {
    typealias Toast = ToastModel

    var title: String
    var image: String
    var message: String
    var color: Color
    var dismiss: (() -> Void)?

    var body: some View {
        HStack(spacing: 21) {
            Image(systemName: image)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(color)
                .opacity(0.5)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .foregroundColor(color).bold()

                Text(message)
                    .foregroundColor(AppColor.textMainNormal.color)
            }
            .font(.footnote)
            .lineLimit(1)

            Spacer()

            if dismiss != nil { dismissButton.transition(.offset(y: -120)) }
        }
        .padding(.horizontal, 21)
        .padding(.vertical, 13)
        .background(Color.white)
        .cornerRadius(15)
    }

    // MARK: Interactions

    private var dismissButton: some View {
        Button { dismiss?() } label: {
            Image(systemName: "xmark")
                .scaledToFit(height: 13)
                .foregroundColor(AppColor.accentGrayMain.color)
        }
    }
}

// MARK: Initializers

extension Toast1View {
    init(toast: ToastModel, dismiss: (() -> Void)?) {
        title = toast.title
        image = toast.type.image
        message = toast.message
        color = toast.type.color
        self.dismiss = dismiss
    }
}


// MARK: - Preview

struct Toast1View_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppColor.backgroundMain.color.edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                Toast1View(toast: ToastModel.failureSample, dismiss: nil)
                Toast1View(toast: ToastModel.failureSampleDismissable, dismiss: nil)
                Toast1View(toast: ToastModel.successSample, dismiss: nil)
                Toast1View(toast: ToastModel.successSampleDismissable, dismiss: nil)
                Toast1View(toast: ToastModel.warningSample, dismiss: nil)
                Toast1View(toast: ToastModel.infoSample, dismiss: nil)
            }
            .padding(.horizontal, 16)
        }
        .previewDevice("iPhone 12")
    }
}

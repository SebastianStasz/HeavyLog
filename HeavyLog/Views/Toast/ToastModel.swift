//
//  ToastModel.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 25/07/2021.
//

import SwiftUI

struct ToastModel {
    let title: String
    let message: String
    let type: ToastType
    let isDismissable: Bool
    let presentingTime: Double

    init(title: String, message: String, type: ToastType, isDismissable: Bool = false, presentingTime: Double = 2.5) {
        self.title = title
        self.message = message
        self.type = type
        self.isDismissable = isDismissable
        self.presentingTime = presentingTime
    }
}

// MARK: - Toast Type

extension ToastModel {

    enum ToastType {
        case success
        case failure
        case warning
        case info

        var image: String {
            switch self {
            case .success:
                return "checkmark.circle"
            case .failure:
                return "xmark.circle"
            case .warning:
                return "exclamationmark.circle"
            case .info:
                return "info.circle"
            }
        }

        var color: Color {
            switch self {
            case .success:
                return Color(red: 49/255, green: 189/255, blue: 167/255)
            case .failure:
                return Color(red: 244/255, green: 71/255, blue: 75/255)
            case .warning:
                return Color(red: 243/255, green: 136/255, blue: 41/255)
            case .info:
                return Color(red: 0/255, green: 96/255, blue: 206/255)
            }
        }
    }
}

// MARK: - Helpers

extension ToastModel: Equatable {}

// MARK: - Sample Data

extension ToastModel {
    static let sampleFailure = ToastModel(title: "Server error", message: "Your photo could not upload.", type: .failure)
    static let sampleFailureDismissable = ToastModel(title: "Server error", message: "Your photo could not upload.", type: .failure, isDismissable: true)

    static let sampleSuccess = ToastModel(title: "The operation was successful", message: "Profile photo was updated.", type: .success)
    static let sampleSuccessDismissable = ToastModel(title: "Success", message: "Profile photo was updated.", type: .success, isDismissable: true)

    static let sampleWarning = ToastModel(title: "Warning", message: "Sample warning message.", type: .warning)
    static let sampleInfo = ToastModel(title: "Information", message: "Sample information message.", type: .info)
    static let sampleInfoLong = ToastModel(title: "Information", message: "Sample information message which is a bit long.", type: .info, isDismissable: true, presentingTime: 5)
}

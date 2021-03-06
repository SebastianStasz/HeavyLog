//
//  BodyParameter.swift
//  HeavyLogCoreData
//
//  Created by Sebastian Staszczyk on 21/08/2021.
//

import CoreData
import Foundation
import Shared

public enum BodyParameter: String {
    case height
    case weight
    case waistline
    case chest
    case biceps
    case hips
    case thigh
    case calf
    case unknown

    public var name: String {
        nameLocalized.key.localize()
    }

    public static var possibleCases: [BodyParameter] {
        BodyParameter.allCases.dropLast()
    }

    public func getLastValue(in context: NSManagedObjectContext) -> Double? {
        BodyParameterEntity.getLastValue(for: self, in: context)
    }
}

extension BodyParameter {
    private var nameLocalized: LocalizedString {
        switch self {
        case .height:
            return LocalizedString.common_bodyParameter_height
        case .weight:
            return LocalizedString.common_bodyParameter_weight
        case .waistline:
            return LocalizedString.common_bodyParameter_waistline
        case .chest:
            return LocalizedString.common_bodyPart_chest
        case .biceps:
            return LocalizedString.common_bodyPart_biceps
        case .hips:
            return LocalizedString.common_bodyParameter_hips
        case .thigh:
            return LocalizedString.common_bodyParameter_thigh
        case .calf:
            return LocalizedString.common_bodyParameter_calf
        case .unknown:
            return LocalizedString.error_enum_unknown
        }
    }
}

// MARK: - Helpers

extension BodyParameter: CaseIterable {}

extension BodyParameter: Identifiable {
    public var id: String { rawValue }
}

extension BodyParameter: UnknownValueSupport {
    public static var unknownCase: BodyParameter { .unknown }
}

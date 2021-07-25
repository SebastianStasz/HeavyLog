//
//  DateHelper.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 25/07/2021.
//

import Foundation

class DateHelper {
    static let shared = DateHelper()

    private let cachedDateFormattersQueue = DispatchQueue(label: "com.boles.date.formatter.queue")
    private var cachedDateFormatters: [String: DateFormatter] = [:]

    func string(from date: Date, format: DateFormatter.Style, withTime time: Bool) -> String {
        cachedDateFormatter(withFormat: format, time: time).string(from: date)
    }

    func string(from date: Date, format: String) -> String {
        cachedDateFormatter(withFormat: format).string(from: date)
    }

    private func cachedDateFormatter(withFormat format: DateFormatter.Style, time: Bool) -> DateFormatter {
        cachedDateFormattersQueue.sync {
            let key = "\(format.rawValue) \(time ? 100 : 0)"

            if let cachedFormat = cachedDateFormatters[key] { return cachedFormat }

            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateStyle = format
            if time { dateFormatter.timeStyle = .short }

            cachedDateFormatters[key] = dateFormatter
            return dateFormatter
        }
    }

    private func cachedDateFormatter(withFormat format: String) -> DateFormatter {
        cachedDateFormattersQueue.sync {
            if let cachedFormat = cachedDateFormatters[format] { return cachedFormat }

            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = format

            cachedDateFormatters[format] = dateFormatter
            return dateFormatter
        }
    }
}

// MARK: - Extensions

extension Date {

    func string(format: DateFormatter.Style, withTime time: Bool = false) -> String {
        DateHelper.shared.string(from: self, format: format, withTime: time)
    }

    func string(format: String) -> String {
        DateHelper.shared.string(from: self, format: format)
    }
}

extension Optional where Wrapped == Date {

    func string(format: DateFormatter.Style, withTime time: Bool = false) -> String {
        guard let date = self else { return "None" }
        return date.string(format: format, withTime: time)
    }

    func string(format: String) -> String {
        guard let date = self else { return "None" }
        return date.string(format: format)
    }
}

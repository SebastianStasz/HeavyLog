//
//  ToolbarItem+Ext.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 04/09/2021.
//

import SwiftUI

struct Toolbar {}

extension Toolbar {

    static func close(action: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(.common_close) { action() }
        }
    }

    static func cancel(action: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(.common_cancel) { action() }
        }
    }

    static func leading(_ text: String, action: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(text) { action() }
        }
    }

    static func trailing(_ text: String, action: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(text) { action() }
        }
    }

    static func trailing(systemImage: String, action: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(systemImage: systemImage, action: action())
        }
    }

    static func leading(systemImage: String, action: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(systemImage: systemImage, action: action())
        }
    }

    static func delete(action: @escaping () -> Void) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            HStack {
                Button(.common_delete) { action() }
                    .buttonStyle(TextButtonStyle(.destructive))
                Spacer()
            }
        }
    }
}

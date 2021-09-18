//
//  TabBarVM.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 25/07/2021.
//

import Foundation

final class TabBarVM: ObservableObject {
    typealias Tab = TabBarModel

    @Published var selectedTab: Tab = .dashboard
    @Published var arePopupsShown = false

    private unowned let parent: AppVM

    init(parent: AppVM) {
        self.parent = parent
    }

    var availableTabs: [Tab] { Tab.allCases }
}

// MARK: - Navigator

extension TabBarVM {

    enum Destination {
        case tab(Tab)
        case popupItems
        case view
        case workoutSheet
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .tab(let tab):
            selectedTab = tab
        case .popupItems:
            arePopupsShown = true
        case .view:
            dismissPopups()
        case .workoutSheet:
            goToWorkoutCreator()
        }
    }

    private func goToWorkoutCreator() {
        guard let vm = parent.workoutCreatorVM else {
            parent.startWorkout()
            navigate(to: .workoutSheet)
            return
        }
        AppController.shared.present(sheet: .workout(viewModel: vm))
        dismissPopups()
    }

    private func dismissPopups() {
        arePopupsShown = false
    }
}
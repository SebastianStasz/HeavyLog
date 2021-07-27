//
//  AppVM.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 25/07/2021.
//

import SwiftUI

@main
struct HeavyLogApp: App {

    var body: some Scene {
        WindowGroup {
            AppView(appVM: AppVM.shared)
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}

// MARK: - App Controller

final class AppController {
    static let shared = AppController()

    private unowned let app: AppVM

    init(appVM: AppVM = AppVM.shared) {
        self.app = appVM
    }

    func present(toast: ToastModel) {
        app.toastPresenter.presentToast(toast)
    }

    func present(alert: AlertModel) {
        guard app.alert == nil else { return }
        app.alert = alert
    }

    func present(actionSheet: ActionSheetModel) {
        guard app.actionSheet == nil else { return }
        app.actionSheet = actionSheet
    }

    func present(sheet: SheetModel) {
        guard app.sheet == nil else { return }
        app.sheet = sheet
    }
}

// MARK: - App View Model

final class AppVM: ObservableObject {
    static fileprivate let shared = AppVM()

    @Published private(set) var tabBarVM: TabBarVM?
    @Published private(set) var toastPresenter = ToastPresenterVM()
    @Published var actionSheet: ActionSheetModel?
    @Published var sheet: SheetModel?
    @Published var alert: AlertModel?

    init() {
        tabBarVM = TabBarVM(parent: self)
    }
}

// MARK: - Navigator

extension AppVM {

    enum Destination {
        case startView
        case appView
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .startView:
            tabBarVM = nil
        case .appView:
            tabBarVM = TabBarVM(parent: self)
        }
    }
}

//
//  AppView.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 15/07/2021.
//

import SwiftUI

struct AppView: View {

    @ObservedObject var appVM: AppVM

    var body: some View {
        ZStack {
            TabBarView(viewModel: appVM.tabBarVM!)
                .sheet(item: $appVM.sheet) { $0.screenPresenter(appVM: appVM) }

            if appVM.sheet == nil {
                Color.clear
                    .screenPresenter(appVM: appVM)
                    .transition(.opacity.animation(.easeInOut))
            }

            PopupPresenter($appVM.popup)
        }
    }
}


// MARK: - Preview

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(appVM: AppVM())
    }
}

//
//  ExercisesView.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 10/08/2021.
//

import SwiftUI

struct ExercisesView: View {

    @Environment(\.managedObjectContext) private var context
    @FetchRequest(fetchRequest: ExerciseEntity.createFetchRequest()) private var exercises: FetchedResults<ExerciseEntity>

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .spacingMedium) {
                ForEach(exercises) { exercise in
                    ExerciseTileView(viewData: .init(exercise))
                }
            }
        }
        .padding(.horizontal, .spacingMedium)
        .backgroundIgnoringSafeArea(Color.backgroundMain)
    }
}


// MARK: - Preview

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
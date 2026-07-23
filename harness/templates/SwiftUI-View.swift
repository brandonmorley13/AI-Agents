// Template: SwiftUI feature view.
// Replace <Feature> with the feature name (e.g. Transactions).
// Replace <Model> with the @Observable model type (e.g. TransactionsModel).

import SwiftUI

struct <Feature>View: View {
    @Environment(<Model>.self) private var model
    @State private var error: <Feature>Error?

    var body: some View {
        @Bindable var model = model

        Group {
            if model.isLoading {
                ProgressView()
                    .tint(Theme.accent)
                    .accessibilityLabel(Text("Loading <Feature>"))
            } else if let error {
                <Feature>ErrorView(error: error, retry: { Task { await model.refresh() } })
            } else {
                List {
                    // Feature-specific rows
                }
                .listStyle(.plain)
                .refreshable { await model.refresh() }
            }
        }
        .background(Theme.background)
        .navigationTitle(Text("<Feature>"))
        .task(id: model.id) {
            do { try await model.load() }
            catch let e as <Feature>Error { error = e }
            catch { error = .unknown }
        }
    }
}

#Preview {
    NavigationStack {
        <Feature>View()
            .environment(<Model>(repository: <Feature>Repository.preview))
    }
}

// Template: feature-scoped @Observable model + protocol + repository.
// Replace <Feature> with the feature name (e.g. Transactions).
// Replace <Item> with the primary domain type (e.g. Transaction).

import Foundation
import Observation
import os

protocol <Feature>Managing: AnyObject, Sendable {
    var items: [<Item>] { get }
    var lastUpdated: Date? { get }
    var isLoading: Bool { get }
    func load() async throws
    func refresh() async throws
}

protocol <Feature>Repository: Sendable {
    func fetch() async throws -> [<Item>]
    func refresh() async throws -> [<Item>]
}

enum <Feature>Error: LocalizedError, Sendable {
    case loadFailed(underlying: String)
    case offline
    case unknown

    var errorDescription: String? {
        switch self {
        case .loadFailed: return String(localized: "Couldn't load <Feature>.")
        case .offline:    return String(localized: "You're offline. We'll retry when you're back online.")
        case .unknown:    return String(localized: "Something went wrong.")
        }
    }
}

private let logger = Logger(subsystem: "com.example.app", category: "data")

@MainActor
@Observable
final class <Feature>Model: <Feature>Managing {
    let id = UUID()
    private(set) var items: [<Item>] = []
    private(set) var lastUpdated: Date?
    private(set) var isLoading: Bool = false

    private let repository: any <Feature>Repository

    init(repository: any <Feature>Repository) {
        self.repository = repository
    }

    func load() async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            items = try await repository.fetch()
            lastUpdated = Date()
            logger.info("<Feature> loaded: count=\(self.items.count)")
        } catch {
            logger.error("<Feature> load failed: \(error.localizedDescription, privacy: .private)")
            throw <Feature>Error.loadFailed(underlying: error.localizedDescription)
        }
    }

    func refresh() async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            items = try await repository.refresh()
            lastUpdated = Date()
        } catch {
            logger.error("<Feature> refresh failed: \(error.localizedDescription, privacy: .private)")
            throw <Feature>Error.loadFailed(underlying: error.localizedDescription)
        }
    }
}

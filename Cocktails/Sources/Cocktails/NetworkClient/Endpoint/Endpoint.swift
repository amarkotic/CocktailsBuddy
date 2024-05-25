import Foundation
import Core

public enum Endpoint {

    private static let baseApiPath = "/api/json/%@/1"

    case details(_ id: String)
    case search(_ query: String)

    var urlString: String {
        Core.ExternalLinks.endpoint + generatePath()
    }

    private var version: Core.ApiVersion {
        switch self {
        default:
            return .v1
        }
    }

    private var path: String {
        switch self {
        case .details:
            return "/lookup.php?i=%@"
        case .search:
            return "/search.php?s=%@"
        }
    }

    private func generatePath() -> String {
        let combinedPath = String(format: Endpoint.baseApiPath, version.rawValue) + path

        switch self {
        case .details(let id):
            return String(format: combinedPath, id)
        case .search(let query):
            return String(format: combinedPath, query)
        }
    }

}

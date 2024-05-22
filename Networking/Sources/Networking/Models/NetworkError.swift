import Foundation

public enum NetworkError: Error, LocalizedError {

    case invalidUrl
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid url."
        case .invalidResponse:
            return "Invalid response from server."
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }

}

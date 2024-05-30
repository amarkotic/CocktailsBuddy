import Networking

// Error created from Networking's NetworkError.
// Currently mapping all BaseApiClient related errors to a generalError as a POC and to keep it as simple as possible.
// If more advanced handling is needed, this enum can be expanded to cover more cases registered in Networking module
enum NetworkError: Error {

    case generalError

}

extension NetworkError {

    init(from model: Networking.NetworkError) {
        self = .generalError
    }

}

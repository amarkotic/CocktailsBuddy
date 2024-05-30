import Networking

// Error created from Networking's NetworkError.
// Currently mapping all BaseApiClient related errors to a generalError as a POC and to keep it as simple as possible.
// If more advanced handling is needed, this enum can be expanded to cover more cases registered in Networking module
enum CocktailError: Error {

    case generalError

}

extension CocktailError {

    init(from model: Networking.NetworkError) {
        self = .generalError
    }

}

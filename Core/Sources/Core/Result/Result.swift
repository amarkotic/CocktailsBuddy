import Foundation

public enum Result<T: Equatable>: Equatable {

    case loading
    case success(T)
    case failure

}

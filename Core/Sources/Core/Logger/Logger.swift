import Foundation

public class Logger {

    public static let shared = Logger()

    private init() {}

    public func log(error: Error) {
        print("[ERROR] \(error.localizedDescription)")
    }

}

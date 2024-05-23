import Foundation

public extension DateFormatter {

    static func date(from dateString: String?, dateFormat: DateFormat = .standard) -> Date? {
        guard let dateString else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: dateString)
    }

}

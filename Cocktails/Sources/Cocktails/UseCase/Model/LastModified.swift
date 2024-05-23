import Foundation

enum LastModified {

    case today
    case thisWeek
    case thisMonth
    case thisYear
    case yearsAgo(_ numberOfYears: Int)

    init?(from dateModified: Date?) {
        guard let dateModified else { return nil }

        let calendar = Calendar.current
        let now = Date()

        if calendar.isDateInToday(dateModified) {
            self = .today
            return
        }

        if calendar.isDate(dateModified, equalTo: now, toGranularity: .weekOfYear) {
            self = .thisWeek
            return
        }

        if calendar.isDate(dateModified, equalTo: now, toGranularity: .month) {
            self = .thisMonth
            return
        }

        if calendar.isDate(dateModified, equalTo: now, toGranularity: .year) {
            self = .thisYear
            return
        }

        let components = calendar.dateComponents([.year], from: dateModified, to: now)
        if let years = components.year {
            self = .yearsAgo(years)
            return
        }

        return nil
    }

    var description: String {
        switch self {
        case .today:
            "Today"
        case .thisWeek:
            "This week"
        case .thisMonth:
            "This month"
        case .thisYear:
            "This year"
        case .yearsAgo(let numberOfYears):
            "\(numberOfYears) years ago"
        }
    }

}

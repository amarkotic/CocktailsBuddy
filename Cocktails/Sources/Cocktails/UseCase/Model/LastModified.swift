import Foundation

enum LastModified {

    case today
    case thisWeek
    case thisMonth
    case thisYear
    case yearsAgo(_ numberOfYears: Int)

    init?(from dateModified: Date?) {
        guard let dateModified = dateModified else { return nil }

        let calendar = Calendar.current
        let now = Date()

        if calendar.isDateInToday(dateModified) {
            self = .today
        } else if calendar.isDate(dateModified, equalTo: now, toGranularity: .weekOfYear) {
            self = .thisWeek
        } else if calendar.isDate(dateModified, equalTo: now, toGranularity: .month) {
            self = .thisMonth
        } else if calendar.isDate(dateModified, equalTo: now, toGranularity: .year) {
            self = .thisYear
        } else if let years = calendar.dateComponents([.year], from: dateModified, to: now).year {
            self = .yearsAgo(years)
        } else {
            return nil
        }
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

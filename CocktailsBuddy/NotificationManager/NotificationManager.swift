import Foundation
import UserNotifications
import Dependencies
import RealmSwift
import Cocktails
import Core

class NotificationManager: NotificationManagerProtocol, DependencyKey {

    @Dependency(\.localDataSource) private var localDataSource: LocalDataSourceProtocol

    public static let liveValue: any NotificationManagerProtocol = NotificationManager()

    func scheduleDailyNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { [weak self] requests in
            // If there is an already registered notification request with identifier dailyCocktailReminder, then return
            guard
                let self = self,
                !requests.contains(where: { $0.identifier == NotificationIdentifier.dailyReminder.rawValue }),
                let content = self.configureNotificationContent()
            else { return }

            let trigger = self.configureNotificationTrigger()
            let identifier = NotificationIdentifier.dailyReminder.rawValue

            registerNotification(identifier: identifier, content: content, trigger: trigger)
        }
    }

}

// MARK: - Notification configuration
private extension NotificationManager {

    func configureNotificationContent() -> UNMutableNotificationContent? {
        guard
            let cocktail = localDataSource.getCocktail(id: nil),
            let cocktailName = cocktail.name
        else { return nil }

        let content = UNMutableNotificationContent()
        content.title = "Cocktails Time!"
        content.body = "Did you try out \(cocktailName)? Check it out again and have a lovely drink!"
        content.userInfo = ["cocktailID": cocktail.id]
        content.sound = .default

        return content
    }

    func configureNotificationTrigger() -> UNCalendarNotificationTrigger {
        UNCalendarNotificationTrigger(dateMatching: DailyNotificationTime.time, repeats: true)
    }

}

// MARK: - Notification registrattion
private extension NotificationManager {

    func registerNotification(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error { Logger.shared.log(error: error) }
        }
    }

}

extension DependencyValues {

    var notificationManager: NotificationManagerProtocol {
        get { self[NotificationManager.self] }
        set { self[NotificationManager.self] = newValue }
    }

}

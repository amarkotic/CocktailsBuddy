import Foundation
import UserNotifications
import Dependencies
import RealmSwift
import Cocktails

class NotificationManager: NotificationManagerProtocol, DependencyKey {

    @Dependency(\.localDataSource) private var localDataSource: LocalDataSourceProtocol

    public static var liveValue: any NotificationManagerProtocol = NotificationManager()

    func scheduleDailyNotification() {
        let content = configureNotificationContent()
        let dateComponents = configureDateComponent()

        // Create the trigger as a repeating event
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Create the request and add it to the notification center
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    // If user accesed any cocktail details, it gets saved to local DB. Fetch cocktail name from it to personalize PN
    private func configureNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Cocktails Time!"
        content.sound = .default

        if let cocktailModelName = localDataSource.getCocktail(id: nil)?.name {
            content.body = "Did you try out \(cocktailModelName)? Check it out again and have a lovely drink!"
        } else {
            content.body = "Every day is a cocktail day. Check out new recipes now!"
        }

        return content
    }

    // Send this push notification daily at 20:30
    private func configureDateComponent() -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 30

        return dateComponents
    }

}

extension DependencyValues {

    var notificationManager: NotificationManagerProtocol {
        get { self[NotificationManager.self] }
        set { self[NotificationManager.self] = newValue }
    }

}

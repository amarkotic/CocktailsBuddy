import UIKit
import UserNotifications
import Dependencies
import Cocktails
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UNUserNotificationCenterDelegate {

    @Dependency(\.notificationManager) var notificationManager: NotificationManagerProtocol

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        // Set the notification delegate and request permission
        UNUserNotificationCenter.current().delegate = self
        requestNotificationPermission()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        notificationManager.scheduleDailyNotification()
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if let cocktailID = response.notification.request.content.userInfo["cocktailID"] as? String {
            mainCoordinator?.deepLinkToCocktailDetails(for: cocktailID)
        }
        completionHandler()
    }

}

private extension SceneDelegate {

    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error { Logger.shared.log(error: error) }
        }
    }

}

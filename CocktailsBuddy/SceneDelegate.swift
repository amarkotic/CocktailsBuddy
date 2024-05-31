import UIKit
import Dependencies

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    @Dependency(\.notificationManager) var notificationManager: NotificationManagerProtocol

    var window: UIWindow?
    var cocktailsCoordinator: MainCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        cocktailsCoordinator = MainCoordinator(navigationController: navigationController)
        cocktailsCoordinator?.start()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        notificationManager.scheduleDailyNotification()
    }

}

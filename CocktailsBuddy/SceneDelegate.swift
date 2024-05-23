import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        struct SomeView: View {

            var body: some View {
                Text("hello")
            }

        }

        let view = SomeView()

        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = rootView
        window.rootViewController = UIHostingController(rootView: view)
        self.window = window
        window.makeKeyAndVisible()
    }

}

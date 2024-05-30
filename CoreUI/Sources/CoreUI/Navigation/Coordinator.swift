import SwiftUI
import UIKit

// Protocol which every coordinator across the app has to conform
// Rule of thumb is that each module has it's coordinator, and all of them are managed by MainCoordinator in the root
public protocol Coordinator {

    var navigationController: UINavigationController { get set }

    func start()

}

// Default implementation of often used methods
extension Coordinator {

    public func pushHostingViewController<T: View>(with view: T) {
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
    }

    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }

    public func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

}

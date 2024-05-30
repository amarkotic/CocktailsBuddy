import SwiftUI
import UIKit

public protocol Coordinator {

    var navigationController: UINavigationController { get set }

    func start()

}

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

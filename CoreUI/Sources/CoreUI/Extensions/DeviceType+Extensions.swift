import UIKit

public struct DeviceType {

    public static var isMobile: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

}

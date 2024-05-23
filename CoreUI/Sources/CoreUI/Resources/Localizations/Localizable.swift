import Foundation

/**
 Formalizes resolving localizations in feature module oriented codebase.
 Implement this protocol when adding new localizable file in a feature module.
 */
public protocol Localizable {

    /**
     Gets localized string for provided localization key
     */
    var localized: String { get }

}

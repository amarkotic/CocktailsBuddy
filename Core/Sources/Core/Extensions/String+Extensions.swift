public extension String {

    // BE requires all spaces to be replaced with underscore for request parameters
    var configuredForRequest: String {
        self.replacingOccurrences(of: " ", with: "_")
    }

}

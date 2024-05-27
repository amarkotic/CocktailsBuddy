import Foundation
import Core

struct Endpoint {

    private let path: String
    private let queryItems: [URLQueryItem]

    var url: URL? {
          var components = URLComponents()
          components.scheme = EndpointConfiguration.transferProtocol
          components.host = EndpointConfiguration.endpoint
          components.path = path
          components.queryItems = queryItems
          return components.url
      }

    init(path: String, items: [URLQueryItem] = []) {
        self.path = "\(EndpointConfiguration.basePath)/\(EndpointConfiguration.apiVersion)\(path)"
        self.queryItems = items
    }

}

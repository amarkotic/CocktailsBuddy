import Foundation
import Core

struct Endpoint {

    let path: String
    let queryItems: [URLQueryItem]

    var url: URL? {
          var components = URLComponents()
          components.scheme = EndpointConfiguration.transferProtocol
          components.host = EndpointConfiguration.endpoint
          components.path = path
          components.queryItems = queryItems
          return components.url
      }

}

extension Endpoint {

    init(path: String, items: [URLQueryItem] = []) {
        self.path = "\(EndpointConfiguration.basePath)/\(EndpointConfiguration.apiVersion)\(path)"
        self.queryItems = items
    }

}

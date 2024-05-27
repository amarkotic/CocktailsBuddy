import Foundation

extension Endpoint {

    static func details(id: String) -> Endpoint {
        Endpoint(
            path: "/lookup.php",
            items: [URLQueryItem(name: "i", value: id)])
    }

    static func search(query: String) -> Endpoint {
        Endpoint(
            path: "/search.php",
            items: [URLQueryItem(name: "s", value: query)])
    }

    static var randomDetails: Endpoint {
        Endpoint(path: "/random.php")
    }

    static func filter(type: FilterType) -> Endpoint {
        Endpoint(
            path: "/list.php",
            items: [URLQueryItem(name: type.queryKey, value: "list")])
    }

}

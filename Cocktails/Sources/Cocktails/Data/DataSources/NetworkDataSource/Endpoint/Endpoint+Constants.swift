import Foundation

extension Endpoint {

    static func details(id: String) -> Endpoint {
        Endpoint(path: "/lookup.php", items: [URLQueryItem(name: "i", value: id)])
    }

    static func search(query: String) -> Endpoint {
        Endpoint(path: "/search.php", items: [URLQueryItem(name: "s", value: query)])
    }

    static var randomDetails: Endpoint {
        Endpoint(path: "/random.php")
    }

    static func filter(type: FilterType) -> Endpoint {
        Endpoint(path: "/list.php", items: [URLQueryItem(name: type.queryKey, value: "list")])
    }

    static func applyFilter(model: AppliedFiltersNetworkDataSourceModel) -> Endpoint {
        let path = "/filter.php"
        var items: [URLQueryItem] = []
        if let alcoholFilter = model.alcohol {
            items.append(URLQueryItem(name: "a", value: alcoholFilter))
        }
        if let categoryFilter = model.category {
            items.append(URLQueryItem(name: "c", value: categoryFilter))
        }
        if let glassFilter = model.glass {
            items.append(URLQueryItem(name: "g", value: glassFilter))
        }

        print(Endpoint(path: path, items: items).url)
        return Endpoint(path: path, items: items)
    }

}

//
//  MagicRouter.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 07/08/22.
//

import Foundation
import Alamofire

public enum MagicRouter: URLRequestConvertible {

    case sets([SetSearchParameter]?)
    case cards([CardSearchParameter]?)
    case types
    case subtypes
    case supertypes
    case formats

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .sets:
            return "/sets"
        case .cards:
            return "/cards"
        case .types:
            return "/types"
        case .subtypes:
            return "/subtypes"
        case .supertypes:
            return "/supertypes"
        case .formats:
            return "/formats"
        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .sets(let setParameters):
            return buildQueryItemsFromParameters(setParameters)
        case .cards(let cardParameters):
            return buildQueryItemsFromParameters(cardParameters)
        default:
            return nil
        }
    }

    static let urlScheme: String = "https"
    static let urlBase: String = "api.magicthegathering.io/v1"

    public func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = MagicRouter.urlScheme
        urlComponents.host = MagicRouter.urlBase
        urlComponents.path = path
        urlComponents.queryItems = parameters

        guard let url = urlComponents.url else {
            print("ERROR: Couldn't create the full URL")
            return URLRequest(url: try MagicRouter.urlBase.asURL())
        }
        let request = try URLRequest(
            url: url,
            method: method
        )

        return request
    }

    private func buildQueryItemsFromParameters(_ parameters: [SearchParameter]?) -> [URLQueryItem]? {
        guard let parameters = parameters else {
            return nil
        }

        var queryItems = [URLQueryItem]()

        for parameter in parameters {
            let name = parameter.name
            let value = parameter.value
            let item = URLQueryItem(name: name, value: value)
            queryItems.append(item)
        }

        return queryItems
    }

}

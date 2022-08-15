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
            return "/v1/sets"
        case .cards:
            return "/v1/cards"
        case .types:
            return "/v1/types"
        case .subtypes:
            return "/v1/subtypes"
        case .supertypes:
            return "/v1/supertypes"
        case .formats:
            return "/v1/formats"
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
    static let urlBase: String = "api.magicthegathering.io"

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

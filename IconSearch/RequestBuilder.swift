//
//  RequestBuilder.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation

class RequestBuilder {
    
    static let baseURL = "https://api.iconfinder.com/v4"
    static let wordAPIBaseURL = "https://api.datamuse.com/words"
    
    enum Endpoint {
        case getSearchResults(query: String)
        case getAllCategories
        case getAllIconsetsForCategory(identifier: String)
        case getAllIconsInIconset(setId: Int)
        case getIconDetails(iconId: Int)
        case getWords(word: String)
        
        var urlString: String {
            switch self {
            case .getSearchResults(let query):
                let resultCount = 50
                return "\(RequestBuilder.baseURL)/icons/search?query=\(query)&count=\(resultCount)"
            case .getAllCategories:
                let categoryCount = 50
                return "\(RequestBuilder.baseURL)/categories?count=\(categoryCount)"
            case .getAllIconsetsForCategory(let identifier):
                let iconsetCount = 50
                return "\(RequestBuilder.baseURL)/categories/\(identifier)/iconsets?count=\(iconsetCount)"
            case .getAllIconsInIconset(let setId):
                let iconCount = 50
                return "\(RequestBuilder.baseURL)/iconsets/\(setId)/icons?count=\(iconCount)"
            case .getIconDetails(let iconId):
                return "\(RequestBuilder.baseURL)/icons/\(iconId)"
            case .getWords(word: let word):
                return "\(RequestBuilder.wordAPIBaseURL)?sp=\(word)*"
            }
        }
    }
    
}

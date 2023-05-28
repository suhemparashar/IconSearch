
//
//  CategoryData.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation

struct CategoryData: Codable {
    let totalCount: Int?
    let categories: [Categories]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case categories
    }
}

struct Categories: Codable {
    let name: String
    let identifier: String
}

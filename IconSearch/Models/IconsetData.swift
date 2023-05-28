//
//  IconsetData.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation

struct IconsetData: Codable {
    let totalCount: Int?
    let iconsets: [Iconsets]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case iconsets
    }
}

struct Iconsets: Codable {
    let iconsetId: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iconsetId = "iconset_id"
        case name
    }
}

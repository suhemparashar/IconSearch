//
//  SearchData.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation

struct SearchData: Codable {
    let totalCount: Int?
    let icons: [Icons]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case icons
    }
}

struct Icons: Codable {
    let iconId: Int?
    let isPremium: Bool?
    let rasterSizes: [RasterSizes]?

    enum CodingKeys: String, CodingKey {
        case iconId = "icon_id"
        case isPremium = "is_premium"
        case rasterSizes = "raster_sizes"
    }
}

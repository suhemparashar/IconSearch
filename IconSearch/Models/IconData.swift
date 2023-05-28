//
//  IconData.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation

struct IconData: Codable {
    let iconId: Int?
    let rasterSizes: [RasterSizes]?
    
    enum CodingKeys: String, CodingKey {
        case iconId = "icon_id"
        case rasterSizes = "raster_sizes"
    }
}


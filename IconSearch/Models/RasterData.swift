//
//  RasterData.swift
//  IconSearch
//
//  Created by suhemparashar on 27/05/23.
//

import Foundation

struct RasterSizes: Codable {
    let formats: [Formats]?
    let size: Int?
    let sizeWidth: Int?
    let sizeHeight: Int?
    
    enum CodingKeys: String, CodingKey {
        case formats
        case size
        case sizeWidth = "size_width"
        case sizeHeight = "size_height"
    }
}

struct Formats: Codable {
    let previewURL: String?
    
    enum CodingKeys: String, CodingKey {
        case previewURL = "preview_url"
    }
}

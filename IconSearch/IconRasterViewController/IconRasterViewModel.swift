//
//  IconRasterCellViewModel.swift
//  IconSearch
//
//  Created by suhemparashar on 27/05/23.
//

import Foundation
import UIKit

class IconRasterViewModel {
    
    func setUpImageView(imageURLString: String, completion: @escaping (UIImage?) -> Void) {
        let requestHandler = RequestHandler()
        requestHandler.fetchImage(from: imageURLString) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Failed to fetch image: \(error)")
                completion(nil)
            }
        }
    }
}

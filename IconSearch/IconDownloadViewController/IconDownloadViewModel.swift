//
//  IconDownloadViewModel.swift
//  IconSearch
//
//  Created by suhemparashar on 27/05/23.
//

import Foundation
import UIKit


protocol IconDownloadDelegate: AnyObject {
    func apiCallDidComplete()
}
class IconDownloadViewModel {
    
    private let apiManager = IconsSearchAPIManager()
    
    weak var delegate: IconDownloadDelegate?
    var icons: [Icons]?
    
    func getIconId(index: Int) -> Int?{
        return icons?[index].iconId
    }
    
    func checkIfIconIsPremium(index: Int) -> Bool? {
        return icons?[index].isPremium
    }
    
    func getRasterSizes(index: Int) -> [RasterSizes]? {
        return icons?[index].rasterSizes
    }
    func getIconCount() -> Int? {
        return icons?.count
    }
    func getIconPreview(index: Int) -> String? {
        let rasterSizes:[RasterSizes]? = icons?[index].rasterSizes
        
        let formats:[Formats]? = rasterSizes?[5].formats
        let previewURL: String = formats?[0].previewURL ?? ""
        
        return previewURL
    }
    
    func getIcons(setId: Int){
        
        let request = RequestBuilder.Endpoint.getAllIconsInIconset(setId: setId)
        let urlString = request.urlString
        
        apiManager.getAllIconsInIconsetAPI(urlString: urlString) { result in
            switch result {
            case .success(let model):
                self.icons = model.icons
                self.delegate?.apiCallDidComplete()
            case .failure(let error):
                print(error)
            }
        }
    }
    
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



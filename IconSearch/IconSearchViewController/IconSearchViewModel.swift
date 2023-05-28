//
//  IconSearchViewModel.swift
//  IconSearch
//
//  Created by suhemparashar on 28/05/23.
//

import Foundation
import UIKit


protocol IconSearchDelegate: AnyObject {
    func apiCallDidComplete()
}


class IconSearchViewModel {
    
    private let apiManager = IconsSearchAPIManager()
    var icons: [Icons]?
    weak var delegate: IconDownloadDelegate?
    
    func getIconCount() -> Int? {
        return icons?.count
    }
    
    func checkIfIconIsPremium(index: Int) -> Bool? {
        return icons?[index].isPremium
    }
    
    func getIconPreview(index: Int) -> String? {
        let rasterSizes:[RasterSizes]? = icons?[index].rasterSizes
        var idx = 0
        if let cnt = rasterSizes?.count{
            idx = cnt >= 6 ? 5 : cnt - 1
        }
        let formats:[Formats]? = rasterSizes?[idx].formats
        let previewURL: String = formats?[0].previewURL ?? ""
        
        return previewURL
    }
    
    func getSearchResults(queryParam: String){
        let request = RequestBuilder.Endpoint.getSearchResults(query: queryParam)
        let urlString = request.urlString
        
        apiManager.getSearchResultsAPI(urlString: urlString) { result in
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

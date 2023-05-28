//
//  IconsetsViewModel.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation


protocol IconsetsDelegate: AnyObject {
    func apiCallDidComplete()
}
class IconsetsViewModel {
    private let apiManager = IconsSearchAPIManager()
    private var iconSets:[Iconsets]?
    weak var delegate: IconsetsDelegate?
    
    func getIconsetsCount()->Int?{
        return iconSets?.count ?? 0
    }
    
    func getIconsetName(index: Int)->String?{
        return iconSets?[index].name
    }
    
    func getIconsetId(index: Int)->Int? {
        return iconSets?[index].iconsetId
    }
    func getIconsets(identifier: String){
        let request = RequestBuilder.Endpoint.getAllIconsetsForCategory(identifier:identifier)
        let urlString = request.urlString
        apiManager.getAllIconsetsForCategoryAPI(urlString: urlString) { result in
            switch result {
            case .success(let model):
                self.iconSets = model.iconsets
                self.delegate?.apiCallDidComplete()
            case .failure(let error):
                print(error)
            }
        }
    }
}

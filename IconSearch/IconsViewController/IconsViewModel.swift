//
//  IconsViewModel.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation

protocol IconsDelegate: AnyObject {
    func apiCallDidComplete()
}

class IconsViewModel {
    
    private let apiManager = IconsSearchAPIManager()
    private var categories:[Categories]?
    //private var words:[Word]?
    weak var delegate: IconsDelegate?
    
    
    func getCategoryCount()->Int?{
        return categories?.count ?? 0
    }
    
    func getCategory(index: Int)->String?{
        return categories?[index].name
    }
    func getCategoryIdentifier(index: Int)->String?{
        return categories?[index].identifier
    }
    
    func getCategories(){
        let request = RequestBuilder.Endpoint.getAllCategories
        let urlString = request.urlString
        apiManager.getAllCategoriesAPI(urlString: urlString) { result in
            switch result {
            case .success(let model):
                self.categories = model.categories
                self.delegate?.apiCallDidComplete()
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func getWords(word: String){
//
//        let request = RequestBuilder.Endpoint.getWords(word: word)
//        let urlString = request.urlString
//        apiManager.getWordsAPI(urlString: urlString){ result in
//            switch result {
//            case .success(let model):
//                self.words = model
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
    func getWords(word: String, completion: @escaping ((Result<[Word], Error>) -> Void?)){
        
        let request = RequestBuilder.Endpoint.getWords(word: word)
        let urlString = request.urlString
        apiManager.getWordsAPI(urlString: urlString){ result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

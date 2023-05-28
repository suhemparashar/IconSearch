//
//  IconsSearchAPIManager.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import Foundation


class IconsSearchAPIManager {
    
    private let requestHandler = RequestHandler()
    
    func getSearchResultsAPI(urlString: String, completion: @escaping ((Result<SearchData, Error>) -> Void?)){
        
            requestHandler.makeRequest(urlString: urlString, modelType: SearchData.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllCategoriesAPI(urlString: String, completion: @escaping ((Result<CategoryData, Error>) -> Void?)){
        
            requestHandler.makeRequest(urlString: urlString, modelType: CategoryData.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllIconsetsForCategoryAPI(urlString: String, completion: @escaping ((Result<IconsetData, Error>) -> Void?)){
        
            requestHandler.makeRequest(urlString: urlString, modelType: IconsetData.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllIconsInIconsetAPI(urlString: String, completion: @escaping ((Result<SearchData, Error>) -> Void?)){
        
            requestHandler.makeRequest(urlString: urlString, modelType: SearchData.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getIconDetailsAPI(urlString: String, completion: @escaping ((Result<IconData, Error>) -> Void?)){
        
            requestHandler.makeRequest(urlString: urlString, modelType: IconData.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWordsAPI(urlString: String, completion: @escaping ((Result<[Word], Error>) -> Void?)){
        
            requestHandler.makeRequest(urlString: urlString, modelType: [Word].self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

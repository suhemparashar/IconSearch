



import Foundation
import UIKit

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}

class RequestHandler {
    
    func makeRequest<T: Codable>(urlString: String, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let apiKey = "Bearer 2dXnOTz2Jjh8OYjALMppUfHVwQGcIIrZpqD2zoBjhmAnUjymuUHrVe7OiUYEmZJS"
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(modelType, from: responseData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let imageData = data, let image = UIImage(data: imageData) else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            completion(.success(image))
        }
        
        task.resume()
    }
    
    func fetchWords<T: Codable>(urlString: String, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(modelType, from: responseData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}



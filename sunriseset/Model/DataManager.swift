//
//  DataManager.swift
//  sunriseset
//
//  Created by Mohammed Al-Quraini on 8/12/21.
//

import UIKit

struct DataManager {
    private let stringUrl = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400"
    
    func fetchData(lat : Double, lng : Double,completion : @escaping (Result) -> Void){
        let updatedUrl = "https://api.sunrise-sunset.org/json?lat=\(lat)&lng=\(lng)"
        
        performRequest(updatedUrl: updatedUrl, completion: completion)
        
        
    }
    
    private func performRequest(updatedUrl : String,completion : @escaping (Result) -> Void){
        // 1. Create a url
        guard let url = URL(string: updatedUrl) else {
            return
        }
        
        // 2. Create a url session
        let session = URLSession(configuration: .default)
        
        // 3. Give the session a task
        let task = session.dataTask(with: url) { data , response, error in
            if error != nil {
                return
            }
            
            guard let safeData = data else {
                return
            }
            
            guard let callbackData = parseJson(safeData) else {return}
            
            completion(callbackData)
            
            
        }
        
        // 4. Start the task
        task.resume()
        
    }
    
    private func parseJson(_ data : Data) -> Result? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(DataModel.self, from: data)
            
            return decodedData.results
        } catch {
//            print(error)
            return nil
        }
    }
    
    
    
    
}

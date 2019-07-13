//
//  NetworkService.swift
//  Collection View
//
//  Created by Alex Kagarov on 7/13/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import Foundation

class NetworkService {
    func getData(completion: @escaping Constants.DownloadCompleted) {
        guard let requestUrl = URL(string: Constants.url) else {return}
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data,response,error) in
            
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode([Response].self, from: data)
                print(result)
                
                completion(data)
            }
            catch let error {
                print(error)
            }
            
        }
        task.resume()
    }
}

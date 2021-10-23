//
//  NetworkController.swift
//  traeger_coding_challenge
//
//  Created by Ryan Bitner on 10/22/21.
//

import Foundation
import SwiftUI

class NetworkController {
    
    let apiKey = "tnnvHlPGz8Zv1IFnGT7XsW4OLJ5r2bxiCtgFrdlj"
    
    func getAPODs(startDate: String, endDate: String, completion: @escaping (Result<[apod], Error>) -> Void) {
        let url = "https://api.nasa.gov/planetary/apod"
        var urlComp = URLComponents(string: url)!
        let queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate)
        ]
        urlComp.queryItems = queryItems
        let task = URLSession.shared.dataTask(with: urlComp.url!) { data, response, err in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let apods = try jsonDecoder.decode(Array<apod>.self, from: data)
                    completion(.success(apods))
                } catch {
                    guard let err = err else {return}
                    completion(.failure(err))
                }
            }
        }
        task.resume()
    }
    
    func getAPOD(apod: apod, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let url = URL(string: apod.url)!
        let data = try? Data(contentsOf: url)
        if let data = data, let image = UIImage(data: data) {
            completion(.success(image))
        }
    }
}

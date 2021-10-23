//
//  APODService.swift
//  traeger_coding_challenge
//
//  Created by Ryan Bitner on 10/22/21.
//

import Foundation
import SwiftUI

class APODService: ObservableObject {
    
    let networkController = NetworkController()

    let endDate = Date()
    let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!

    @Published var apods = [apod]()
    
    func getAPODS() {
        networkController.getAPODs(startDate: startDate.string(), endDate: endDate.string()) { result in
            switch result {
            case .success(let apods):
                DispatchQueue.main.async {
                    self.apods = apods
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
}


extension Date {
    func string() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
}

//
//  NetworkService.swift
//  JsonParsing
//
//  Created by Hayk Sakulyan on 18.09.23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var corses:[DataModel] = []
    
    let baseURL = "https://iosacademy.io/api/v1/courses/index.php"
    
    func fetch() {
        guard let url = URL(string: baseURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            
            //Convert to JSON
            
            do {
                let courses = try JSONDecoder().decode([DataModel].self, from: data)
                DispatchQueue.main.async {
                    self?.corses = courses
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

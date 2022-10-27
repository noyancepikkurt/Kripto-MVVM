//
//  WebService.swift
//  Kripto MVVM
//
//  Created by Noyan Çepikkurt on 27.10.2022.
//

import Foundation

class WebService {
    
    func downloadCurrencies(url : URL, completion: @escaping ([CryptoCurrency]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                
                completion(cryptoList)
            }
        }.resume()
    }
    
    
}

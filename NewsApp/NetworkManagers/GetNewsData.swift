//
//  GetNewsData.swift
//  NewsApp
//
//  Created by MacBook on 16.04.2022.
//

import Foundation

class WebService {
    
    static func getArticlesData(completion: @escaping ([News]?) -> ()) {
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&apiKey=c6fd2f49033a420cab4f1e86192f4d8d") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                completion(nil)
                
            }else if let data = data {
                
                let articleList = try? JSONDecoder().decode(NewsResponse.self, from: data)
                
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                
                print(articleList?.articles ?? "")
            }
        }.resume()
    }    
}


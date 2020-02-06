//
//  Func.swift
//  news
//
//  Created by Roman Dvoritskiy on 06.02.2020.
//  Copyright © 2020 Roman Dvoritskiy. All rights reserved.
//

import Foundation

class Func {
    static let shared = Func()
    var articles: [Article]? = []
    
    func fetchArticles(fromSource source: String) {

        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?\(source)&apiKey=123ffc6d70e5439a9a071575c704aa6d")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            self.articles = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let author = articleFromJson["author"] as? String, let title = articleFromJson["title"] as? String, let descriptions =  articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let imageToUrl = articleFromJson["urlToImage"] as? String {
                            article.author = author
                            article.descriptions = descriptions
                            article.imageUrl = imageToUrl
                            article.headline = title
                            article.url = url
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async {
//                    vc.tableView.reloadData()
                    
                }
            } catch let error {
                print(error)
            }
            
        }
        task.resume()
    }
}

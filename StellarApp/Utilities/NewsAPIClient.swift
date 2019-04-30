import Foundation
import UIKit

final class ApiClient {
    static func getNews (query: String, completionHandler: @escaping(AppError?, [ArticleWrapper]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://newsapi.org/v2/everything?q=\(query)&apiKey=\(SecretKeys.NewsAPIKey)", httpMethod: "GET", httpBody: nil) { (appError, data, response) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            if let data = data {
                do {
                    let news = try JSONDecoder().decode(NewsData.self, from: data)
                    let articles = news.articles
                    completionHandler(nil, articles)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}

    
       
    


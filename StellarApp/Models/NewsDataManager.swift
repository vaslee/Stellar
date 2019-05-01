//
//  NewsDataManage.swift
//  StellarApp
//
//  Created by Ramu on 4/12/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import Foundation

//final class NewsDataManager {
//    private init() {}
//    
//    private static let filename = "NewsData.plist"
//    static private var news = [NewsData]()
//    static public func fetchNewsFromDocumentDirectory() -> [NewsData] {
//        var news = [NewsData]()
//        let path = DataPersistenceManger.filepathToDocumentsDirectory(filename: filename).path
//        if FileManager.default.fileExists(atPath: path) {
//            if let data = FileManager.default.contents(atPath: path) {
//                do {
//                    news = try PropertyListDecoder().decode([NewsData].self, from: data)
//                    self.news = news
//                } catch {
//                    print("property list is encoding error: \(error)")
//                }
//            } else {
//                print("data is nil")
//            }
//        }
//        return news
//    }
//
//    static func delete(news: NewsData, atIndex index: Int) {
//        var news = fetchNewsFromDocumentDirectory()
//        news.remove(at: index)
//        let path = DataPersistenceManger.filepathToDocumentsDirectory(filename: filename)
//        do {
//            let data = try PropertyListEncoder().encode(news)
//            try data.write(to: path, options: Data.WritingOptions.atomic)
//        } catch {
//            print("property list encoding error: \(error)")
//        }
//    }
//}

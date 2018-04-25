//
//  MovieAPI.swift
//  TestingApp
//
//  Created by Richard Crichlow on 4/24/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case badURL(url: String)
    case badImageURL(url: String)
    case badData
    case badResponseCode(code: Int)
    case cannotParseJSON(rawError: Error)
    case noInternet
    case notAnImage
    case other(rawError: Error)
}

class MovieAPI {
    private init() {}
    static let manager = MovieAPI()
    func searchMovies(keyword: String, completionHandler: @escaping (Error?, Data?) -> Void) {
        let urlString = "https://itunes.apple.com/search?media=movie&term=comedy&limit=100"
        guard let url = URL(string: urlString) else {
            completionHandler(AppError.badURL(url: urlString), nil)
            return
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            completionHandler(nil, data)
        }, errorHandler: { (error) in
            completionHandler(AppError.other(rawError: error), nil)
        })
    }
}

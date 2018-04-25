//
//  ImageAPIHelper.swift
//  TestingApp
//
//  Created by Richard Crichlow on 4/25/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation
import UIKit



class ImageAPIClient{
    private init() {}
    static let manager = ImageAPIClient()
    
    
    
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void){
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL(url: urlStr))
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else{
                errorHandler(.notAnImage)
                return
            }
            completionHandler(onlineImage)
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: {print($0.localizedDescription)})
    }
}

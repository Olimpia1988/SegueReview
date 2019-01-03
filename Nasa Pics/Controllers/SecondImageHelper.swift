//
//  SecondImageHelper.swift
//  Nasa Pics
//
//  Created by Olimpia on 1/3/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

struct SecondImageHelper {
    static func secondPicture(strUrl: String, completionHandler: @escaping(AppError?, UIImage?)-> Void) {
        guard let url2 = URL.init(string: strUrl) else {
            completionHandler(AppError.badURL(strUrl), nil)
             return
        }
        let req = URLRequest.init(url: url2)
    
        URLSession.shared.dataTask(with: req) {
            (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
            } else if let data = data {
                let laFoto = UIImage.init(data: data)
                completionHandler(nil, laFoto)
            }
        }.resume()
    }
}

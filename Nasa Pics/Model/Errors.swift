//
//  ErrorHandeling.swift
//  Nasa Pics
//
//  Created by Olimpia on 1/2/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case noResponse
    case decodingError(Error)
  
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let message):
            return "badURL: \(message)"
        case .networkError(let error):
            return "networkError: \(error)"
        case .noResponse:
            return "no network response"
        case .decodingError(let error):
            return "decoding error: \(error)" 
        }
    }
}

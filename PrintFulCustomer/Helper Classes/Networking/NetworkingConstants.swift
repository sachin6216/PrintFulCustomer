//
//  NetworkingConstants.swift
// 
//  Created by Sachin on 31/03/23.
//

import Foundation
struct ApisURL {
    /// Base Url
    // MARK: - App URL's
    static let baseURl = "http://api.weatherstack.com/" //Local
    
    enum ServiceUrls: String {
        // Home
        case getCurrentWeather = "current?access_key=dca2525df9d6f96a77dd5f35e8ff4911"
    }
}

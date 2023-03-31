//
//  NetworkingConstants.swift
// 
//  Created by Sachin on 31/03/23.
//

import Foundation
struct ApisURL {
    /// Base Url
    // MARK: - App URL's
    static let baseURl = "https://api.printful.com" //Local
    
    enum ServiceUrls: String {
        // Home
        case getCategories = "/categories"
        case getProductList = "/products?category_id="
        case getProductDetails = "/products/"
    }
}

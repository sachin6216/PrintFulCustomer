//
//  HomeEndPoint.swift
//
//  Created by Sachin on 31/03/23
//
import Foundation
import UIKit
import Alamofire
enum HomeEndPoint: TargetType {
    
    case getCategories
    case getProductList(categoryId: String)
    case getProductDetails(productId: String)
    var data: [String: Any] {
        switch self {
        default:
            return [:]
        }
    }
    var service: String {
        switch self {
        case .getCategories: return ApisURL.ServiceUrls.getCategories.rawValue
        case .getProductList(categoryId: let categoryId):
            return "\(ApisURL.ServiceUrls.getProductList.rawValue)\(categoryId)"
        case .getProductDetails(productId: let productId): return "\(ApisURL.ServiceUrls.getProductDetails.rawValue)\(productId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCategories, .getProductList, .getProductDetails:
            return .get
        }
    }
    
    var isJSONRequest: Bool {
        switch self {
        case .getCategories, .getProductList, .getProductDetails:
            return false
        }
    }
    var multipartBody: MulitPartParam? {
        switch self {
        default:
            return nil
        }
    }
    var headers: [String: String]? {
        return nil
    }
    var instance: ApiManager {
        return .init(targetData: self)
    }
}

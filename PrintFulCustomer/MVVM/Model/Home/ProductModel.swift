//
//  ProductModel.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import Foundation
class ProductModel {
    var dataResponse: [ProductList]?
    var categoryId: String?
}
// MARK: - GetProductList
struct GetProductList: Codable {
    let code: Int?
    let result: [ProductList]?
    let error: ErrorModal?
}
// MARK: - ProductList
struct ProductList: Codable {
    let id, main_category_id: Int?
    let image: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case main_category_id = "main_category_id"
        case image = "image"
        case title
    }
}

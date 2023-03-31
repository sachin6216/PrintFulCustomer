//
//  ProductDetailsModel.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import Foundation
class ProductDetailsModel {
    var productDetailsResponse: DataGetProductDetails?
    var productId: String?
    var isSelectedSizeIndex: Int?
    var isDescDropExpand = false
}
// MARK: - GetProductDetails
struct GetProductDetails: Codable {
    let code: Int?
    let result: DataGetProductDetails?
    let error: ErrorModal?
}
// MARK: - ErrorModal
struct ErrorModal: Codable {
    let reason, message: String?
}
// MARK: - DataGetProductDetails
struct DataGetProductDetails: Codable {
    let product: Product?
    let variants: [Variant]?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let description, title: String?
    let image, currency: String?

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case title, image
        case currency
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id, productID: Int?
    let name, size, color, colorCode: String?
    let image: String?
    let price: String?
    let inStock: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, size, color
        case colorCode = "color_code"
        case image, price
        case inStock = "in_stock"
    }
}

//
//  HomeModel.swift
//
//  Created by Sachin on 31/03/23.
//

import Foundation
class HomeModel {
    var dataResponse: [Category]?
}
// MARK: - GetCategories
struct GetCategories: Codable {
    let code: Int?
    let result: DataGetCategories?
    let error: ErrorModal?
}

// MARK: - Result
struct DataGetCategories: Codable {
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let id, parentID: Int?
    let imageURL: String?
    let catalogPosition: Int?
    let size: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case imageURL = "image_url"
        case catalogPosition = "catalog_position"
        case size, title
    }
}

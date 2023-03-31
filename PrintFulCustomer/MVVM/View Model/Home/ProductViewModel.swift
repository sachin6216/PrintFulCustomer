//
//  ProductViewModel.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import UIKit
import Foundation
import Combine

class ProductViewModel {
    var model = ProductModel()
    var getProductListPublisher: AnyPublisher<String, Never> {
        getProductListSubject.eraseToAnyPublisher()
    }
    let getProductListSubject = PassthroughSubject<String, Never>()
    
    /// Get all products from the server
    func getProductList(controller: UIViewController) {
        Connectivity.shared.startLoad()
        HomeEndPoint.getProductList(categoryId: self.model.categoryId ?? "").instance.executeQuery { (response: GetProductList) in
            Connectivity.shared.endLoad()
            if response.result?.isEmpty == false {
                self.model.dataResponse = response.result
                self.getProductListSubject.send("")
            } else {
                controller.showalertview(messagestring: "\(response.error?.message ?? "")")
            }
        } error: { (errorMsg) in
            Connectivity.shared.endLoad()
            controller.showalertview(messagestring: errorMsg ?? "")
        }
    }
}

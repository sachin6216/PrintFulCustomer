//
//  ProductDetailsViewModel.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import UIKit
import Foundation
import Combine

class ProductDetailsViewModel {
    var model = ProductDetailsModel()
    var getProductDetailsPublisher: AnyPublisher<String, Never> {
        getProductDetailsSubject.eraseToAnyPublisher()
    }
    let getProductDetailsSubject = PassthroughSubject<String, Never>()
    
    /// Get  products details from the server
    func getProductDetails(controller: UIViewController) {
        Connectivity.shared.startLoad()
        HomeEndPoint.getProductDetails(productId: self.model.productId ?? "").instance.executeQuery { (response: GetProductDetails) in
            Connectivity.shared.endLoad()
            if let dataResponse = response.result {
                self.model.productDetailsResponse = dataResponse
                self.getProductDetailsSubject.send("")
            } else {
                controller.showalertview(messagestring: "\(response.error?.message ?? "")")
            }
        } error: { (errorMsg) in
            Connectivity.shared.endLoad()
            controller.showalertview(messagestring: errorMsg ?? "")
        }
    }
}

//
//  HomeViewModel.swift
//
//  Created by Sachin on 31/03/23.
//
import UIKit
import Foundation
import Combine

class HomeViewModel {
    var model = HomeModel()
    var getCategoriesPublisher: AnyPublisher<String, Never> {
        getCategoriesSubject.eraseToAnyPublisher()
    }
    let getCategoriesSubject = PassthroughSubject<String, Never>()
    
    /// Get all categories from the server
    func getCategories(controller: UIViewController) {
        Connectivity.shared.startLoad()
        HomeEndPoint.getCategories.instance.executeQuery { (response: GetCategories) in
            Connectivity.shared.endLoad()
            if response.result?.categories?.isEmpty == false {
                self.model.dataResponse = response.result?.categories
                self.getCategoriesSubject.send("")
            } else {
                controller.showalertview(messagestring: "\(response.error?.message ?? "")")
            }
        } error: { (errorMsg) in
            Connectivity.shared.endLoad()
            controller.showalertview(messagestring: errorMsg ?? "")
        }
    }
}

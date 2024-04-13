//
//  HomeRoute.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-13.
//

import Foundation
enum HomeRoute: Hashable {
    case productDetails(Product)
    case postNewProduct
}

class HomeNavigationCoordinator: ObservableObject {
    @Published var routes: [HomeRoute] = []
}

//
//  HomeRoute.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-08.
//

import Foundation
enum HomeRoute: Hashable {
    case productDetails(Product)
    case postNewProduct
    case chat(chatRoom: ChatRoom, otherUser: User, productId: String)
}

class HomeNavigationCoordinator: ObservableObject {
    @Published var routes: [HomeRoute] = []
}


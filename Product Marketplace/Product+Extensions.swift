//
//  Product+Extensions.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-08.
//

import Foundation

extension Product: Hashable {
    // 1
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.price == rhs.price &&
        lhs.productDescription == rhs.productDescription
    }
    
    // 2
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(price)
        hasher.combine(productDescription)
    }
}

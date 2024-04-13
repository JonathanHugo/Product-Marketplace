//
//  Product+Extensions.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-13.
//

import Foundation

extension Product: Identifiable {}

extension Product: Hashable {
    // 1
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.price == rhs.price &&
        lhs.productDescription == rhs.productDescription &&
        lhs.artist == rhs.artist &&
        lhs.releaseYear == rhs.releaseYear &&
        lhs.length == rhs.length &&
        lhs.songsCount == rhs.songsCount &&
        lhs.genre == rhs.genre
    
    }
    
    // 2
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(price)
        hasher.combine(productDescription)
        hasher.combine(artist)
        hasher.combine(releaseYear)
        hasher.combine(length)
        hasher.combine(songsCount)
        hasher.combine(genre)
    }
}

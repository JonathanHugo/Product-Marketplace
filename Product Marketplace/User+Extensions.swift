//
//  User+Extensions.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-08.
//

import Foundation
extension User: Hashable {
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id &&
        lhs.username == rhs.username
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
    }
}

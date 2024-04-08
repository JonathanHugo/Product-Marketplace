//
//  ChatRoom+Extensions.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-08.
//

import Foundation

// 1
extension ChatRoom: Identifiable {}
// 2
extension ChatRoom: Hashable {
    public static func == (lhs: ChatRoom, rhs: ChatRoom) -> Bool {
        lhs.id == rhs.id &&
        lhs.memberIds == rhs.memberIds
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(memberIds)
    }
}
// 3
extension ChatRoom {
    func otherMemberId(currentUser id: String) -> String {
        guard let otherMemberId = self.memberIds?.first(where: { String($0) != id }) else {
            return "" // Return empty string if no other member ID found
        }
        return String(otherMemberId)
    }
}


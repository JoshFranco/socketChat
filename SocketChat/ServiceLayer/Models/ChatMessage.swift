//
//  ChatMessage.swift
//  SocketChat
//
//  Created by Josh Franco on 1/5/21.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let message: String
    let isFromMe: Bool
    
    // MARK: - Init
    init(message: String, isFromMe: Bool) {
        self.id = UUID()
        self.message = message
        self.isFromMe = isFromMe
    }
}

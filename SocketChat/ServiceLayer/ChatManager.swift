//
//  ChatManager.swift
//  SocketChat
//
//  Created by Josh Franco on 1/5/21.
//

import Foundation
import SocketIO

class ChatManager: ObservableObject {
    
    
    private let manager: SocketManager
    private let socket: SocketIOClient
    
    // MARK: - Init
    init() {
        let newManager = SocketManager(socketURL: URL(string: "https://interval-takehome-chatbot.onrender.com")!,
                                       config: [.log(true), .compress,.secure(true)])
        self.manager = newManager
        self.socket = newManager.defaultSocket
        
        testSomeStuff()
    }
    
    func testSomeStuff() {
        socket.on(clientEvent: .connect) { _, _ in
            print("CONNECTED!")
        }
    }
}

//
//  ChatManager.swift
//  SocketChat
//
//  Created by Josh Franco on 1/5/21.
//

import Foundation
import SocketIO

class ChatManager: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var currentMsgStr = ""
    @Published var isConnected = false
    
    private let manager: SocketManager
    private let socket: SocketIOClient
    private let chatEvent = "chat"
    
    var showMic: Bool {
        currentMsgStr.isEmpty
    }
    
    // MARK: - Init
    init() {
        let newManager = SocketManager(socketURL: URL(string: "https://interval-takehome-chatbot.onrender.com")!,
                                       config: [.log(true), .compress,.secure(true)])
        self.manager = newManager
        self.socket = newManager.defaultSocket
        
        connectSocket()
    }
    
    init(previewData: [ChatMessage]) {
        let newManager = SocketManager(socketURL: URL(string: "https://interval-takehome-chatbot.onrender.com")!,
                                       config: [.log(true), .compress,.secure(true)])
        self.manager = newManager
        self.socket = newManager.defaultSocket
        self.messages = previewData
    }
    
    // MARK: - Util
    func sendMsg() {
        let newMsg = ChatMessage(message: currentMsgStr, isFromMe: true)
        
        messages.append(newMsg)
        socket.emit(chatEvent, newMsg.message)
        
        if !currentMsgStr.isEmpty {
            currentMsgStr.removeAll()
        }
    }
}

private extension ChatManager {
    func connectSocket() {
        socket.on(clientEvent: .connect) { [weak self] _, _ in
            guard let self = self else { return }
            
            self.isConnected = true
        }
        
        socket.on(clientEvent: .disconnect) { [weak self] _, _ in
            guard let self = self else { return }
            
            self.isConnected = false
        }
        
        socket.on(chatEvent) { [weak self] data, ack in
            guard let self = self else { return }
            
            let strData = data.compactMap({ $0 as? String })
            strData.forEach({ self.messages.append(.init(message: $0, isFromMe: false)) })
            
            print("adding strData: \(strData)")
        }
        
        socket.connect()
    }
}

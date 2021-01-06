//
//  ChatBubbleView.swift
//  SocketChat
//
//  Created by Josh Franco on 1/5/21.
//

import SwiftUI

struct ChatBubbleView<Content>: View where Content: View {
    let direction: ChatBubbleShape.Direction
    let content: () -> Content
    
    // MARK: - Body
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            
            content()
                .padding()
                .foregroundColor((direction == .right) ? .white: .black)
                .background((direction == .right) ? Color.blue: Color.lightGray)
                .clipShape(ChatBubbleShape(direction: direction))
            
            if direction == .left {
                Spacer()
            }
        }
        .padding([(direction == .left) ? .leading : .trailing], 20)
        .padding((direction == .right) ? .leading : .trailing, 50)
    }
    
    // MARK: - Init
    init(direction: ChatBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.direction = direction
    }
    
}

// MARK: - Preview
struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            ChatBubbleView(direction: .right) {
                Text("Hello World!!!")
            }
            
            ChatBubbleView(direction: .left) {
                Text("Hi, its nice to meet speak to you")
            }
            
            ChatBubbleView(direction: .right) {
                Text("Thx")
            }
        }
    }
}

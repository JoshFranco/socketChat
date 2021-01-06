//
//  ChatView.swift
//  SocketChat
//
//  Created by Josh Franco on 1/5/21.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var manager: ChatManager
    @State private var showAlert = false
    private var scrollToid = 99
    private var genericAlert: Alert {
        Alert(title: Text("Whoops!"),
              message: Text("Feature was deemed out of scope for this iteration of the project"),
              dismissButton: .default(Text("Ok")))
        
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ChatHeaderView(alertToggle: $showAlert)
                    .background(Color.offWhite.edgesIgnoringSafeArea(.top))
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.btnGray)
                    .opacity(0.5)
            }
            
            
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { reader in
                    LazyVStack(spacing: 8) {
                        ForEach(manager.messages) { msg in
                            ChatBubbleView(direction: msg.isFromMe ? .right: .left) {
                                Text(msg.message)
                            }
                        }
                        
                        Rectangle()
                            .frame(height: 30, alignment: .center)
                            .foregroundColor(Color.clear).id(scrollToid)
                        Scroll(reader: reader)
                    }
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Image(systemName: "chevron.right.square.fill")
                        .resizable()
                        .foregroundColor(.btnGray)
                        .frame(width: 30, height: 30)
                })
                
                HStack {
                    TextField("iMessage", text: $manager.currentMsgStr, onCommit:  {
                        manager.sendMsg()
                        
                    })
                    
                    Button(action: {
                        if manager.showMic {
                            showAlert.toggle()
                        } else {
                            manager.sendMsg()
                        }
                    }, label: {
                        Image(systemName: manager.showMic ? "mic.circle.fill": "arrow.up.circle.fill")
                            .resizable()
                            .foregroundColor(manager.showMic ? .btnGray: .blue)
                            .frame(width: 30, height: 30)
                    })
                }
                .padding(.vertical, 4)
                .padding(.leading, 16)
                .padding(.trailing, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.btnGray, lineWidth: 1)
                )
                
                
            }
            .padding()
        }
        .alert(isPresented: $showAlert, content: { genericAlert })
    }
}

// MARK: - Private
private extension ChatView {
    func Scroll(reader: ScrollViewProxy) -> some View {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation {
                reader.scrollTo(scrollToid)
            }
        }
        
        return EmptyView()
    }
}

// MARK: - Preview
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(ChatManager(previewData: [.init(message: "test msg from me", isFromMe: true),
                                                         .init(message: "test from NOT me", isFromMe: false)]))
    }
}

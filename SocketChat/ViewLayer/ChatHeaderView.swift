//
//  ChatHeaderView.swift
//  SocketChat
//
//  Created by Josh Franco on 1/5/21.
//

import SwiftUI

struct ChatHeaderView: View {
    @Binding var alertToggle: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                alertToggle.toggle()
            }, label: {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 15, height: 20)
                    
                    Image(systemName: "2.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            })
            .frame(width: 44, height: 44)
            
            Spacer()
            
            VStack {
                Image("santa")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                
                Text("Santa")
                    .font(.footnote)
            }
            
            
            
            Spacer()
            
            Button(action: {
                alertToggle.toggle()
            }, label: {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
            .frame(width: 44, height: 44)
        }
        .padding()
    }
}

struct ChatHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeaderView(alertToggle: .constant(false))
    }
}

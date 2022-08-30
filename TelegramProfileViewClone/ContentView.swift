//
//  ContentView.swift
//  TelegramProfileViewClone
//
//  Created by Sung Park on 2022/08/30.
//

import SwiftUI
import SwiftUITrackableScrollView

struct ContentView: View {
    @State private var scrollOffset: CGFloat = .zero
    @State private var isRectangleMode: Bool = false
    @State private var animate = true
    @Namespace var profileBG
    
    var body: some View {
        ZStack(alignment: .top) {
            scrollView
            if isRectangleMode {
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(.title2)
                                .bold()
                                .scaleEffect(scale, anchor: .bottomLeading)
                            .matchedGeometryEffect(id: "username", in: profileBG)
                            Text("+82 10-0000-0000 • n@n30gu1.com")
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: "contacts", in: profileBG)
                        }
                        .padding()
                        Spacer()
                    }
                }
                .background(Color.green.matchedGeometryEffect(id: "bg", in: profileBG))
                .frame(width: UIScreen.main.bounds.width, height: 400 - scrollOffset, alignment: .top)
                .onTapGesture {
                    self.isRectangleMode = false
                }
                .ignoresSafeArea()
            }
        }
    }
    
    var scrollView: some View {
        TrackableScrollView(.vertical, showIndicators: true, contentOffset: $scrollOffset) {
            LazyVStack {
                if !isRectangleMode {
                    Circle()
                        .matchedGeometryEffect(id: "bg", in: profileBG)
                        .frame(width: 150, height: 150, alignment: .top)
                        .scaleEffect(scale, anchor: .bottom)
                        .foregroundColor(.green)
                        .onTapGesture {
                            withAnimation {
                                self.isRectangleMode = true
                            }
                        }
                    Text("Username")
                        .font(.title)
                        .matchedGeometryEffect(id: "username", in: profileBG)
                    Text("+82 10-0000-0000 • n@n30gu1.com")
                        .foregroundColor(.gray)
                        .matchedGeometryEffect(id: "contacts", in: profileBG)
                }
            }
        }.onChange(of: scrollOffset, perform: { newValue in
            withAnimation(.easeOut(duration: 0.1)) {
                switch newValue {
                case ...(-100):
                    isRectangleMode = true
                    break
                case 1...:
                    isRectangleMode = false
                    break
                default:
                    break
                }
            }
        })
    }
    
    var scale: Double {
        switch scrollOffset {
        case ...0:
            return 1 + (-scrollOffset) / 300
        default:
            return 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

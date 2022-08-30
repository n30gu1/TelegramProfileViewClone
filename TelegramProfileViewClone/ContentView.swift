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
    @State private var largeHeader: Bool = false
    @State private var animate = true
    @Namespace var profileNamespace
    
    var body: some View {
        ZStack(alignment: .top) {
            scrollView
                .background(Color(uiColor: UIColor.systemGroupedBackground))
            if largeHeader {
                largeHeaderView
            }
        }
    }
    
    var largeHeaderView: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.title2)
                        .bold()
                        .scaleEffect(scale, anchor: .bottomLeading)
                    .matchedGeometryEffect(id: "username", in: profileNamespace)
                    Text("+82 10-0000-0000 • n@n30gu1.com")
                        .foregroundColor(.gray)
                        .matchedGeometryEffect(id: "contacts", in: profileNamespace)
                }
                .padding()
                Spacer()
            }
        }
        .background(Color.green.matchedGeometryEffect(id: "bg", in: profileNamespace))
        .frame(width: UIScreen.main.bounds.width, height: 400 - scrollOffset, alignment: .top)
        .onTapGesture {
            self.largeHeader = false
        }
        .ignoresSafeArea()
    }
    
    var header: some View {
        LazyVStack {
            Circle()
                .matchedGeometryEffect(id: "bg", in: profileNamespace)
                .frame(width: 150, height: 150, alignment: .top)
                .scaleEffect(scale, anchor: .bottom)
                .foregroundColor(.green)
                .onTapGesture {
                    withAnimation {
                        self.largeHeader = true
                    }
                }
            Text("Username")
                .font(.title)
                .matchedGeometryEffect(id: "username", in: profileNamespace)
            Text("+82 10-0000-0000 • n@n30gu1.com")
                .foregroundColor(.gray)
                .matchedGeometryEffect(id: "contacts", in: profileNamespace)
        }
    }
    
    var scrollView: some View {
        GeometryReader { proxy in
            TrackableScrollView(.vertical, showIndicators: true, contentOffset: $scrollOffset) {
                if !largeHeader {
                    header
                } else {
                    Color.clear
                        .frame(height: 392 - proxy.safeAreaInsets.top - scale)
                }
                Form {
                    if largeHeader {
                        Section {
                            Text("nice!")
                        }
                    }
                    Section {
                        Text("test")
                    }
                }
                .frame(width: proxy.size.width, height: 200)
            }
            .onChange(of: scrollOffset, perform: { newValue in
                withAnimation(.easeOut(duration: 0.1)) {
                    switch newValue {
                    case ...(-100):
                        largeHeader = true
                        break
                    case 1...:
                        largeHeader = false
                        break
                    default:
                        break
                    }
                }
            })
        }
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

//
//  ContentView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RequestMapper()
    
    var body: some View {
        ZStack{
            if let newsArray = viewModel.newsList {
                ScrollView {
                    VStack(spacing:12) {
                        ForEach(newsArray,id: \.self.id) { Element in
                            if Element.title != "" {
                                artCard(newsItem: (
                                    picPath:Element.cover,
                                    title:Element.title,
                                    vicTitle:Element.content,
                                    date:Element.relativeTime,
                                    type:""
                                ))
                            }
                            else{
                                bannerCard(bannerData:(
                                    backgroundImage:Element.cover,
                                    date:Element.created_at,
                                    content:Element.content,
                                    from:Element.from
                                ))
                            }
                        }
                    }
                }
                .padding(12)
            }
        }
        .onAppear{
            viewModel.getNewListData(id: "")
        }
        .frame(width: .infinity,height: .infinity)
        .background(HexColor(rgbValue: 0xf4f4f4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
                ContentView()
    }
}
